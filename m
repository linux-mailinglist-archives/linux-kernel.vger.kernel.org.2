Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E947D43CFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhJ0RsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:48:13 -0400
Received: from ale.deltatee.com ([204.191.154.188]:59030 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbhJ0RsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=2Ya959eOTabpNxgua7bS61RrrdJDd5kKyfHDoHIUf3o=; b=i42/9HxsLxU72AjwCb/X3TDyO6
        MEJuPDe6AT+3ndwsNHg4ajvMMlhBudDwlAvgxUedLigFbpTQ2CqTR/5KsCJy3PjXORKkSnTlJmvfl
        XwlcUw2Q95X+oWqJBlyPr8fohW180pfEINEhFibQo/dcdRSCEzrmM5N5x7RFK51FTTVa6aBxK/RTF
        WFRvQU1Ze/r0oDsk9Kq8Hq8cqELBg5ZTbOV2wA5703iWX91Y6S7xsLPGkTNR9gh4NcLShFcMRMRK0
        X0AV1B7p7K/4e1lP8JAQjyRHWOE094yyzgMvNQhZsavpFCle6iY6dRQahr5DJP1MHvhv3Vb7i9BEn
        84Gt82KA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mfmzc-000koE-V3; Wed, 27 Oct 2021 11:45:42 -0600
To:     Marshall Midden <marshallmidden@gmail.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org
References: <CAD2CkAWjS8=kKwEEN4cgVNjyFORUibzEiCUA-X+SMtbo0JoMmA@mail.gmail.com>
 <d8434a1a-b813-958f-69d7-34007faa49b7@deltatee.com>
 <CAD2CkAV8fWVPdtoxzf5w-q_411Zw_Rwm1QGuz3-Li7eFXehktw@mail.gmail.com>
 <3747d7c3-0cb1-c9b7-8eb8-4d0b167e03fb@deltatee.com>
 <CAD2CkAVvgZU_nFYyjhg6ArNjgxfRvzGbVo0WPHf5+NyaVASJzg@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <31cb0f0d-93d1-d017-ec9f-1405ce97fa30@deltatee.com>
Date:   Wed, 27 Oct 2021 11:45:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAD2CkAVvgZU_nFYyjhg6ArNjgxfRvzGbVo0WPHf5+NyaVASJzg@mail.gmail.com>
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




On 2021-10-27 11:44 a.m., Marshall Midden wrote:
> Try number 2 with plain text definitely selected.
> 
> Forgot to cut and paste -- interruption occurred. The
> "vmcore-dmesg-incomplete.txt" (this file is created before the vmcore
> is taken, and then later in the process, the vmcore-dmesg.txt file is
> created).
> 
> AMD machine after taking dump and rebooting:
>     /media/parsecdata/crash/127.0.0.1-2021-10-27-12:06:53:
>     -rw------- 1 root root 5410206160 Oct 27 12:06 vmcore
>     -rw-r--r-- 1 root root          0 Oct 27 12:06 vmcore-dmesg-incomplete.txt
> 
> Intel machine:
>     /media/parsecdata/crash/127.0.0.1-2021-10-27-12:12:33:
>     -rw------- 1 root root 5482529464 Oct 27 12:12 vmcore
>     -rw-r--r-- 1 root root     236525 Oct 27 12:12 vmcore-dmesg.txt
> 

Ah, so some kind of issue with the testing infrastructure you are using?
Not something we need to be concerned about.

Logan
