Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAB33967F6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhEaS2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 14:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhEaS2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 14:28:44 -0400
Received: from resqmta-ch2-10v.sys.comcast.net (resqmta-ch2-10v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A80C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 11:27:01 -0700 (PDT)
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-10v.sys.comcast.net with ESMTP
        id nkMKlqG16hBVinmcslYdOZ; Mon, 31 May 2021 18:26:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1622485618;
        bh=KhTj3R0Z0R5UQOJkZFsUr6TSa4HAIsNgMHzaVwt+gaY=;
        h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
         MIME-Version:Content-Type;
        b=RxlP43h2ITR6Gm5pKvgki8HY6P9y4nk4oeAdBZ/8zYeU1ZwfAI7z9RthH6jO8gmSy
         tvFsJqx738umgvW930G38tEKocYgumqyTYzTzOb43DnfSd4k3VsfpcPNETE7P+nR0k
         D2MooHADBzqSZ/HtFkX/19yHpkCiDTF4CvFDpgZlSWqJlGYKfrBMXYUfVgCpeubXpr
         hMxGJk34Mnli2MR9aQ6vHWjC1sTNV03fABtFksI4AG890ww7I2gULOmh7Ritp4ZEPW
         VnvS4aMyVYLdM0EqXBDsIq/AIvzf7O+Vxs6m7G6HhGBaFDTu5zxYx+bS/DnzShZdvW
         2uL9YfPcEd5bw==
Received: from [IPv6:2001:558:6040:22:2171:426f:b27e:296d]
 ([IPv6:2001:558:6040:22:2171:426f:b27e:296d])
        by resomta-ch2-11v.sys.comcast.net with ESMTPSA
        id nmcol6PN54dconmcpluhnc; Mon, 31 May 2021 18:26:56 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Reply-To: james@nurealm.net
Subject: Re: [PATCH] x86/thermal: Fix LVT thermal setup for SMI delivery mode
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@suse.de>, linux-smp@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86-ml <x86@kernel.org>
References: <YKjJfu4kRDflQS5e@zn.tnic>
 <373464e3-b8a0-0fe0-b890-41df0eecf090@nurealm.net> <YKqLSqIM7Gi5x+IA@zn.tnic>
 <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net> <YKtbBXZGpVZS1M4R@zn.tnic>
 <1f6c70f4-6680-d6ea-465a-548dc7698317@nurealm.net> <YK905sC/2cVOYo6I@zn.tnic>
 <87h7io8kh5.ffs@nanos.tec.linutronix.de> <YK/q4RyKhoqFM2nJ@zn.tnic>
 <87mtsf6zch.ffs@nanos.tec.linutronix.de> <YLDRuLC1vCu30lF0@zn.tnic>
From:   James Feeney <james@nurealm.net>
Message-ID: <0357878b-a167-cc95-894e-5f553bacfd8b@nurealm.net>
Date:   Mon, 31 May 2021 12:26:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLDRuLC1vCu30lF0@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/21 5:19 AM, Borislav Petkov wrote:
> On Fri, May 28, 2021 at 10:23:42AM +0200, Thomas Gleixner wrote:
>> So you could disable CPU_SUP_INTEL ... Should still boot with reduced
>> functionality.
> 
> *If* you disable it and *if* that intel_init_thermal() is really there
> to unstick those cores, then you might not even boot successfully.
> 
>> What a mess...
> 
> When is it not when SMM is involved?
> 
> That stinking goo underneath the OS needs to be open sourced so that we
> can replace it with something small and sane. BIOS morons will never
> learn not to fiddle with architectural components.
> 

Has the patch that resolves - or at least pacifies - this issue been forwarded downstream to GKH for mainline yet?  I'd like to be able to upgrade with stock kernels again.

James
