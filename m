Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2652942CECC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhJMWnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhJMWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:43:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03AC061772
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UshN0E8eQAR16/FEIymaNkzE8QRtIB5dSeLaVzX2jRk=; b=u/oHF+PNxP4tdZi5mxd4mpFE6i
        Y7TwyvXYdbEXfAtD2mYE9sVacq59SopOxfG8IgynmCuuMESNNhEMDKEu1IzaQX0mnWFf8lHRfakz0
        z6TrgvnNovUn763TGAkNWCwuf3CZmI4r9eCZC85jrz+C+Wn5CKq633vqQtn9Oo27boP+m8viHhdE9
        cndmzgsITVHCB1ik5aNIBI+4lc6nH2dbeg3jpr60Z9bqVrBL0XcTlKxttVEaHIjN75A/VNL5iTEvj
        to0Ojz6pQVaPoH90n0KnevzfsuA4FFjUyIw/P24IHvLOfHdhhET9eZ2Yv2MmAzNhSBAJNVZFdSIsq
        XMn+8ijQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mamux-000uJc-LP; Wed, 13 Oct 2021 22:40:11 +0000
Date:   Wed, 13 Oct 2021 15:40:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mcgrof:modules-next 1/1] include/linux/kern_levels.h:5:18:
 warning: format '%llu' expects argument of type 'long long unsigned int',
 but argument 3 has type 'Elf32_Off' {aka 'unsigned int'}
Message-ID: <YWdgS4LLCTAddGcR@bombadil.infradead.org>
References: <202110140056.Fb6aizTM-lkp@intel.com>
 <c4be5b17-3071-0d99-f896-40040c81d9d3@linuxfoundation.org>
 <YWdNL8m5A3qtIm24@bombadil.infradead.org>
 <5a482ade-7e73-ba6f-457e-75dfdb80a2c8@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a482ade-7e73-ba6f-457e-75dfdb80a2c8@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 04:16:36PM -0600, Shuah Khan wrote:
> On 10/13/21 3:18 PM, Luis Chamberlain wrote:
> > On Wed, Oct 13, 2021 at 11:09:15AM -0600, Shuah Khan wrote:
> > > Hi Luis,
> > > We can introduce arch specific header print routine. Easy option is not
> > > printing any info., which we know isn't very useful.
> > > 
> > > Let me know your thoughts.
> > 
> > You found an issue without the debug prints, and so you'd know better if
> > the effort is worth the trouble, so I'll let you decide.
> > 
> 
> Right the issue with validate_section_offset() is separate from the debug.
> I will fix the pr_err warns first by tweaking the messages to not print
> the variables that cause problems.
> 
> I will send a separate patch for validate_section_offset() which needs to
> be arch specific similar to elf_check_arch().
> 
> Let me know if this plan sounds good.

Sounds good! Thanks for doing this work!

  Luis
