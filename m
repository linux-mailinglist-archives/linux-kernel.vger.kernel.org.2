Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB7C433FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhJSUvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhJSUvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:51:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E595AC06161C;
        Tue, 19 Oct 2021 13:49:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y15so10240436lfk.7;
        Tue, 19 Oct 2021 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=VQTDgaZM3Z/XI5zRatMxhRTR2PstCm1jooAFg0YXZC4=;
        b=dY1aTm2iNoy1tFx3q5N4cbuYzKZv9VlKVEwYN4WYrF9cpMRAudQFCoSyufCNGjAzcH
         ikSgV7zhOdxvLEOn3ht8CLnimRAuUOyO0PzE1BCQHBZtXkf8VTg1R7Aqzh8Ha9jSPtZd
         +T0CQWPfTgqeawNORyT6e+6akKkN3LKA+IORdrc0KqUq0sSQNGEuB9jrcDv3jMI02T0T
         YAW/Vw9nGxirkA5LLnHb+7/bOPAhb97A01Ng2firZRAI9V5Wtc/difEG8KihpipdVUmF
         zOyIp2/rGhhX9YQTzptCcmXz86vEu/IE1GeMI7CKRr/JKEcy4KrkxTpHyIuEkmmbgYjH
         QeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=VQTDgaZM3Z/XI5zRatMxhRTR2PstCm1jooAFg0YXZC4=;
        b=HRGoeBXZ0tASwB7IRJ1aeFTa5MlatdzgtQxv4BqtHzx5+gYjuHuI9KBaxxDI+9HJk8
         JoQahA8MXTRhp7Vp7XjhL05CjndJFfuDiaBT/8GOmrrMkWJsw5DGmRTLGLuxmZpHBgld
         f3/Nax9LHm5TqtGvLTP61JIQ6gCHcs25w5B6swc62j/mR/0CQ6q+NkQJjpZnttDztNUp
         NCrXUMFNb/zTQXVhkI/Fd36oUULw/TJO/Z/TOSfZMIQF0TG3gaT0C3XNwgGaEDYED0Kk
         9h9MWl8fKDNBB3iaYloBV9hElkBSLbJxlBqpz8Bzf/FRM02x2kbwsGmWGd6oENABefBl
         Qthw==
X-Gm-Message-State: AOAM53363o82zs4g/zW3pCCd6A06HjEEon38+NbDn/NPz8yZUM4bWrIf
        kmnXVcAqVackh7ewy21bgSg=
X-Google-Smtp-Source: ABdhPJwlJSSt28V1RzEpuynAjfA5G1qn+CQfc0dggVWDWG8fO4N8qctjEvmvxDDC4Q/PLbi45IITPA==
X-Received: by 2002:a19:4950:: with SMTP id l16mr8230829lfj.248.1634676574111;
        Tue, 19 Oct 2021 13:49:34 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.181])
        by smtp.gmail.com with ESMTPSA id bi1sm18558lfb.290.2021.10.19.13.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 13:49:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Es9l7oID2AeS4qfABKBq6Ec6"
Message-ID: <4617c408-b7f6-8861-4307-ed0ec24283ea@gmail.com>
Date:   Tue, 19 Oct 2021 23:49:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [syzbot] KASAN: use-after-free Read in rtl8712_dl_fw
Content-Language: en-US
To:     syzbot <syzbot+c55162be492189fb4f51@syzkaller.appspotmail.com>,
        Larry.Finger@lwfinger.net, agamkohli9@gmail.com,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000779cb105ceb65376@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000779cb105ceb65376@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------Es9l7oID2AeS4qfABKBq6Ec6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/21 18:29, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8ef1e58783b9 usb: typec: STUSB160X should select REGMAP_I2C
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=1106dcfb300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c27d285bdb7457e2
> dashboard link: https://syzkaller.appspot.com/bug?extid=c55162be492189fb4f51
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12725770b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1168c158b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c55162be492189fb4f51@syzkaller.appspotmail.com
> 

Ok, this driver can't be fixed.... Let's try unregister netdev before 
doing clean up stuff to not race with ->ndo_open()

#syz test: 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing





With regards,
Pavel Skripkin
--------------Es9l7oID2AeS4qfABKBq6Ec6
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9ydGw4NzEyL3VzYl9pbnRmLmMgYi9kcml2
ZXJzL3N0YWdpbmcvcnRsODcxMi91c2JfaW50Zi5jCmluZGV4IDUwNWViZWI2NDNkYy4uY2Fl
MDQyNzJkZWZmIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvcnRsODcxMi91c2JfaW50
Zi5jCisrKyBiL2RyaXZlcnMvc3RhZ2luZy9ydGw4NzEyL3VzYl9pbnRmLmMKQEAgLTU5NSwx
MiArNTk1LDEyIEBAIHN0YXRpYyB2b2lkIHI4NzF4dV9kZXZfcmVtb3ZlKHN0cnVjdCB1c2Jf
aW50ZXJmYWNlICpwdXNiX2ludGYpCiAKIAkvKiBuZXZlciBleGl0IHdpdGggYSBmaXJtd2Fy
ZSBjYWxsYmFjayBwZW5kaW5nICovCiAJd2FpdF9mb3JfY29tcGxldGlvbigmcGFkYXB0ZXIt
PnJ0bDg3MTJfZndfcmVhZHkpOworCWlmIChwbmV0ZGV2LT5yZWdfc3RhdGUgIT0gTkVUUkVH
X1VOSU5JVElBTElaRUQpCisJCXVucmVnaXN0ZXJfbmV0ZGV2KHBuZXRkZXYpOyAvKiB3aWxs
IGNhbGwgbmV0ZGV2X2Nsb3NlKCkgKi8KIAl1c2Jfc2V0X2ludGZkYXRhKHB1c2JfaW50Ziwg
TlVMTCk7CiAJcmVsZWFzZV9maXJtd2FyZShwYWRhcHRlci0+ZncpOwogCWlmIChkcnZwcml2
LmRydl9yZWdpc3RlcmVkKQogCQlwYWRhcHRlci0+c3VycHJpc2VfcmVtb3ZlZCA9IHRydWU7
Ci0JaWYgKHBuZXRkZXYtPnJlZ19zdGF0ZSAhPSBORVRSRUdfVU5JTklUSUFMSVpFRCkKLQkJ
dW5yZWdpc3Rlcl9uZXRkZXYocG5ldGRldik7IC8qIHdpbGwgY2FsbCBuZXRkZXZfY2xvc2Uo
KSAqLwogCXI4NzEyX2ZsdXNoX3J3Y3RybF93b3JrcyhwYWRhcHRlcik7CiAJcjg3MTJfZmx1
c2hfbGVkX3dvcmtzKHBhZGFwdGVyKTsKIAl1ZGVsYXkoMSk7Cg==
--------------Es9l7oID2AeS4qfABKBq6Ec6--

