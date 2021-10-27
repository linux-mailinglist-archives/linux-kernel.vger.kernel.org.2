Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6513343CFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhJ0R1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:27:20 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58860 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhJ0R1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=lSI2t1lnjEJQytf6F001iB4dSFLxXvTU5hlx3bjvWqU=; b=PVLGhrIsoKz7dtffOzQFphucuK
        za/ynu/iXTmtLZ4MbMlZMb0y67a5nxqpkV4VIvRJPKZa/i7+/N8RDOeoKp4LAjjkJo+iLt0r424JX
        J20pJe/HZQEQAh9FpUBNz5Mu8bkeySnpViik5IN9+L29PyOMBDMt/vGFt1x/mNw0tezwWGm79ZDCW
        QHrN3aPBTHYzqY3y9CaQxffGmNweZoe7jlP/CQYP4Mw6z3cDT3qHQTyHWpCJgpWZIdCpXqAm2yoCN
        nJCq+92W9LX/PXLYNDmlyZ8Xmq9Vj2iS7gFRFXw2KwKA92Do0YdchxnCRYIkAapzP3ay4Wxg2WT0S
        Ew6gZWsQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mfmfR-000kcB-HB; Wed, 27 Oct 2021 11:24:50 -0600
To:     Marshall Midden <marshallmidden@gmail.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org
References: <CAD2CkAWjS8=kKwEEN4cgVNjyFORUibzEiCUA-X+SMtbo0JoMmA@mail.gmail.com>
 <d8434a1a-b813-958f-69d7-34007faa49b7@deltatee.com>
 <CAD2CkAV8fWVPdtoxzf5w-q_411Zw_Rwm1QGuz3-Li7eFXehktw@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3747d7c3-0cb1-c9b7-8eb8-4d0b167e03fb@deltatee.com>
Date:   Wed, 27 Oct 2021 11:24:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAD2CkAV8fWVPdtoxzf5w-q_411Zw_Rwm1QGuz3-Li7eFXehktw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, will@kernel.org, joro@8bytes.org, marshallmidden@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: v5.15-rc7 AMD no kernel dump, spews "scsi_dma_map failed: request
 for 36 bytes!"
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 2021-10-27 11:21 a.m., Marshall Midden wrote:
> Yes, the spewing of messages stopped. Kernel crash dump taking is now
> occurring.  Patch applied to v5.15-rc7.
> Reworded: THANKS!  Patch works!
> 
> Dunno why the dmesg isn't right, but at least there is a core image!
> [I updated makedumpfs for v5.15-rc4 -- applying a bunch of cifs/smb,
> qlogic, etc. patches and was getting ready for new kernel release in a
> few weeks -- couldn't debug a cifs crash. :) Down the rabbit hole...
> ;) ]
> Intel machine booted, etc. and it has a dmesg correct. *sigh*  I don't
> think "I" need to worry about that. Someone else can report it.

What do you mean the dmesg isn't "right"? What are you seeing and what
are you expecting? What is it that someone else will be reporting with
Intel machine having a "correct" dmesg?

Logan
