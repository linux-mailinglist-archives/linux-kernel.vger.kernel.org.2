Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696E242CCAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhJMVUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhJMVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:20:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4061FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iBbkO6+7K1qNgwFaaD6mOA0Nx5wvWsBXZzKhZYDB2yY=; b=dsycbtYDmO/9As8EEuCkfnb/g/
        bvLiO/85SibZ//iRW8EMKaVEeve06bhsHhRO5M/nlOzY82/70UDf8sIY0w082LnSwBypMAMlqtNAI
        ZvQ7MG3W6Nf9qT2ILwsdK5lcqGYK6lNyedhGdhRKPnRgxXtfPIlP6ZrBBO6o69dN/MwBIlVtQlFod
        192t1yMljgaEh9/u56PplLxXVXjPQYk1a8n40Y+pCSRMgnYyraRp4oiDt54LhlatjKvyqDv3QATqL
        SQSKGRlsV7Qd5XzVO9EinDrpYPZpz42g4Whea0Rz7vOS1qYe6Ps3GZEXGVWpLIrmH9SeTaDGfx9wq
        /wIKo78w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1male3-000icO-VW; Wed, 13 Oct 2021 21:18:39 +0000
Date:   Wed, 13 Oct 2021 14:18:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mcgrof:modules-next 1/1] include/linux/kern_levels.h:5:18:
 warning: format '%llu' expects argument of type 'long long unsigned int',
 but argument 3 has type 'Elf32_Off' {aka 'unsigned int'}
Message-ID: <YWdNL8m5A3qtIm24@bombadil.infradead.org>
References: <202110140056.Fb6aizTM-lkp@intel.com>
 <c4be5b17-3071-0d99-f896-40040c81d9d3@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4be5b17-3071-0d99-f896-40040c81d9d3@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:09:15AM -0600, Shuah Khan wrote:
> Hi Luis,
> We can introduce arch specific header print routine. Easy option is not
> printing any info., which we know isn't very useful.
> 
> Let me know your thoughts.

You found an issue without the debug prints, and so you'd know better if
the effort is worth the trouble, so I'll let you decide.

  Luis
