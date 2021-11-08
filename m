Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3BD449C48
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 20:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbhKHTVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 14:21:52 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:47940 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbhKHTVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 14:21:51 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:43664)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mkAAb-00E1Hk-GA; Mon, 08 Nov 2021 12:19:05 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:59808 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mkAAZ-002ABU-G3; Mon, 08 Nov 2021 12:19:04 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@kernel.org>
References: <20211102160315.1067553-1-nathan@kernel.org>
Date:   Mon, 08 Nov 2021 13:18:41 -0600
In-Reply-To: <20211102160315.1067553-1-nathan@kernel.org> (Nathan Chancellor's
        message of "Tue, 2 Nov 2021 09:03:15 -0700")
Message-ID: <877ddipib2.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mkAAZ-002ABU-G3;;;mid=<877ddipib2.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+r9bFhQzEzvlEH5/zaHOV1889fUy/lLVc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMGappySubj_01,XMGappySubj_02,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  1.0 XMGappySubj_02 Gappier still
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Nathan Chancellor <nathan@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1107 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.8 (0.4%), b_tie_ro: 3.2 (0.3%), parse: 1.04
        (0.1%), extract_message_metadata: 3.9 (0.4%), get_uri_detail_list:
        1.74 (0.2%), tests_pri_-1000: 3.0 (0.3%), tests_pri_-950: 1.16 (0.1%),
        tests_pri_-900: 0.89 (0.1%), tests_pri_-90: 894 (80.8%), check_bayes:
        892 (80.6%), b_tokenize: 4.8 (0.4%), b_tok_get_all: 711 (64.2%),
        b_comp_prob: 2.2 (0.2%), b_tok_touch_all: 171 (15.4%), b_finish: 0.82
        (0.1%), tests_pri_0: 182 (16.4%), check_dkim_signature: 0.41 (0.0%),
        check_dkim_adsp: 2.2 (0.2%), poll_dns_idle: 0.80 (0.1%), tests_pri_10:
        1.78 (0.2%), tests_pri_500: 6 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] soc: ti: wkup_m3_ipc: Fix return type error in wkup_m3_rproc_boot_thread()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:

> This function should not return a value:
>
> drivers/soc/ti/wkup_m3_ipc.c: In function 'wkup_m3_rproc_boot_thread':
> drivers/soc/ti/wkup_m3_ipc.c:429:16: error: 'return' with a value, in function returning void [-Werror=return-type]
>   429 |         return 0;
>       |                ^
> drivers/soc/ti/wkup_m3_ipc.c:416:13: note: declared here
>   416 | static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

Apologies for not replying to this sooner.  I did not realize at first
that this was in response to one of my changes.

Arnd also reported this and included a correct fix please see:
https://lkml.kernel.org/r/20211105075119.2327190-1-arnd@kernel.org

Thank you,
Eric
>
> Fixes: 111e70490d2a ("exit/kthread: Have kernel threads return instead of calling do_exit")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/soc/ti/wkup_m3_ipc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
> index 0733443a2631..2238beb40f8d 100644
> --- a/drivers/soc/ti/wkup_m3_ipc.c
> +++ b/drivers/soc/ti/wkup_m3_ipc.c
> @@ -425,8 +425,6 @@ static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
>  		dev_err(dev, "rproc_boot failed\n");
>  	else
>  		m3_ipc_state = m3_ipc;
> -
> -	return 0;
>  }
>  
>  static int wkup_m3_ipc_probe(struct platform_device *pdev)
>
> base-commit: ac4fdfaf4792d41ad7b24d1c8ab486aeb7ccd495
