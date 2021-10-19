Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C00D433C01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhJSQZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhJSQZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:25:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D8C061749
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oC9NxNt2iJW2IK32F0lN41UvaJbXlHguecOkspVYEWc=; b=35icRJ+siYytxg32yI7KUoTvqh
        iQiMaTdS5xJSVIM8eNUIzGPXGwm5EG1+o3RwK8jvwwX7I2sVazuY/2+1tnK0sQ+Sa8h0aEh5GaxCJ
        XId3Y9022JFfNDPUZd0llPM4MlWgUtwsU0S2eupN+hoMaevNWPLNNDShMD7faYZ+fTuw/vT+N2nIA
        g2mJS4/m+nJkJ1LdIc65GNDvhcMdCudsZNXLVBRmf7ez6vk6KBk3QaVx3FwOQ+GSnN9Qqfrt/pxn6
        FS82BETEnQLWZOgLEE1LhzSIcrqFRepGcSgLeg7GB9TAd+moivR3UfSZKWvl7dmUr1KF1xjWSCehJ
        6/UllSfA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcrt1-001ulc-9y; Tue, 19 Oct 2021 16:22:47 +0000
Date:   Tue, 19 Oct 2021 09:22:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org, mbenes@suse.com
Subject: Re: [PATCH v2] module: fix validate_section_offset() overflow bug on
 64-bit
Message-ID: <YW7w19d5VgWjB9Mt@bombadil.infradead.org>
References: <20211018173511.26542-1-skhan@linuxfoundation.org>
 <YW3W9t/0axMDXAjv@bombadil.infradead.org>
 <e1ef9645-9386-bf68-4e8d-70828e8c95fe@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ef9645-9386-bf68-4e8d-70828e8c95fe@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 02:57:45PM -0600, Shuah Khan wrote:
> On 10/18/21 2:20 PM, Luis Chamberlain wrote:
> > On Mon, Oct 18, 2021 at 11:35:11AM -0600, Shuah Khan wrote:
> > > validate_section_offset() uses unsigned long local variable to
> > > add/store shdr->sh_offset and shdr->sh_size on all platforms.
> > > unsigned long is too short when sh_offset is Elf64_Off which
> > > would be the case on 64bit ELF headers.
> > > 
> > > This problem was found while adding an error message to print
> > > sh_offset and sh_size. If sh_offset + sh_size exceed the size
> > > of the local variable, the checks for overflow and offset/size
> > > being too large will not find the problem and call the section
> > > offset valid. This failure might cause problems later on.
> > > 
> > > Fix the overflow problem using the right size local variable when
> > > CONFIG_64BIT is defined.
> > > 
> > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > > ---
> > > Changes since v1:
> > > - Updated commit log to describe the fix clearly. No code
> > >    changes.
> > 
> > Thanks! But the implications of your fix is beyond what is described.
> > Although not a real issue today in practice.
> > 
> > I think we should extend it with something like this, let me know
> > what you think (I can just ammend the commit log, no resend would
> > be needed):
> > 
> > Without this fix applied we were shorting the design of modules to
> > have section headers placed within the 32-bit boundary (4 GiB) instead of
> > 64-bits when on 64-bit architectures (which allows for up to 16,777,216
> > TiB). In practice this just meant we were limiting modules to below
> > 4 GiB even on 64-bit systems. This then should not really affect any
> > real-world use case as modules these days obviously should likely never
> > exceed 1 GiB in size. A specially crafted invalid module might succeed to
> > skip validation in validate_section_offset() due to this mistake, but in such
> > case no impact is observed through code inspection given the correct data
> > types are used for the copy of the module when needed on move_module() when
> > the section type is not SHT_NOBITS (which indicates no the section
> > occupies no space on the file).
> > 
> 
> Sounds good to me.

OK pushed with the change above added. Thanks!

  Luis
