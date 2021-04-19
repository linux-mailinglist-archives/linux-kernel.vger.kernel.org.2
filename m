Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48742364CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbhDSVMG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Apr 2021 17:12:06 -0400
Received: from mail02.rohde-schwarz.com ([80.246.32.97]:19666 "EHLO
        mail02.rohde-schwarz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbhDSVMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:12:01 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 17:12:01 EDT
Received: from amu316.rsint.net (10.0.26.65) by mail-emea.rohde-schwarz.com
 (172.21.64.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.858.5; Mon, 19 Apr 2021
 22:56:21 +0200
Subject: RE: Re: [syzbot] INFO: rcu detected stall in tx
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Received: from GMU419.rsint.net ([10.0.230.184])
          by amu316.rsint.net (Totemo SMTP Server) with SMTP ID 935;
          Mon, 19 Apr 2021 22:56:21 +0200 (CEST)
Received: from GMU008.rsint.net (10.0.2.29) by GMU419.rsint.net (10.0.230.184)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Mon, 19 Apr
 2021 22:56:20 +0200
Received: from GMU006.rsint.net (10.0.2.28) by GMU008.rsint.net (10.0.2.29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Mon, 19
 Apr 2021 22:56:19 +0200
Received: from GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b]) by
 GMU006.rsint.net ([fe80::81e7:6ea1:2437:698b%12]) with mapi id
 15.01.2106.013; Mon, 19 Apr 2021 22:56:19 +0200
From:   Guido Kiener <Guido.Kiener@rohde-schwarz.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dpenkler@gmail.com" <dpenkler@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Thread-Topic: Re: [syzbot] INFO: rcu detected stall in tx /cr/
Thread-Index: Adc1XknZ7zhjMD1QSUmt+svgS3FT2Q==
Date:   Mon, 19 Apr 2021 20:56:19 +0000
Message-ID: <d1e8e0608903431e8199d9804fecca36@rohde-schwarz.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-rus_sensitivity: 20
hvs-classificationid: da48e46a-4823-4cc6-82ac-f236c0a43172
hvs-prefix: R_S
x-originating-ip: [10.0.9.40]
X-IQAV: YES
X-GBS-PROC: +DJ8kKkYTDukuJ4lFI4ki04klpYsn7OPmvMIdnipf6hSecQOT+7QKWO8vH/9sEC7U5e9EOsmtJhF90qtJrBQEXHU40BFnKrxlP+KvZ+Ho1C9FzvvTPX5rxAYlB+dOIG6
X-GBS-PROCJOB: HPGX6Ee7lplaR7o29OJF5HOEjxAtyKw3iamF7/sdi6z3MeNA3di9HyuyhcYbjutc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The error is in usbtmc_interrupt(struct urb *urb) since five years. The status code EPROTO is not handled correctly.
It's not a showstopper, but we should fix it and check the status code according to usbtmc_read_bulk_cb() or
usb_skeleton.c.
@Dave: Do you have time? Otherwise I can do it.
@Greg: Is it urgent?

- Guido

-----Original Message-----
From: Dmitry 
Sent: Monday, April 19, 2021 9:27 AM
Subject: Re: [syzbot] INFO: rcu detected stall in tx

On Mon, Apr 19, 2021 at 9:19 AM syzbot
<syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    50987bec Merge tag 'trace-v5.12-rc7' of git://git.kernel.o..
> git tree:       upstream
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=1065c5fcd00000
> kernel config:  
> https://syzkaller.appspot.com/x/.config?x=398c4d0fe6f66e68
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=e2eae5639e7203360018
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com
>
> usbtmc 5-1:0.0: unknown status received: -71 usbtmc 3-1:0.0: unknown 
> status received: -71 usbtmc 5-1:0.0: unknown status received: -71

The log shows an infinite stream of these before the stall, so I assume it's an infinite loop in usbtmc.
+usbtmc maintainers

[  370.171634][    C0] usbtmc 6-1:0.0: unknown status received: -71
[  370.177799][    C1] usbtmc 3-1:0.0: unknown status received: -71
[  370.183912][    C0] usbtmc 4-1:0.0: unknown status received: -71
[  370.190076][    C1] usbtmc 5-1:0.0: unknown status received: -71
[  370.196194][    C0] usbtmc 2-1:0.0: unknown status received: -71
[  370.202387][    C1] usbtmc 3-1:0.0: unknown status received: -71
[  370.208460][    C0] usbtmc 6-1:0.0: unknown status received: -71
[  370.214615][    C1] usbtmc 5-1:0.0: unknown status received: -71
[  370.220736][    C0] usbtmc 4-1:0.0: unknown status received: -71
[  370.226902][    C1] usbtmc 3-1:0.0: unknown status received: -71
[  370.233005][    C0] usbtmc 2-1:0.0: unknown status received: -71
[  370.239168][    C1] usbtmc 5-1:0.0: unknown status received: -71
[  370.245271][    C0] usbtmc 6-1:0.0: unknown status received: -71
[  370.251426][    C1] usbtmc 3-1:0.0: unknown status received: -71
[  370.257552][    C0] usbtmc 4-1:0.0: unknown status received: -71
[  370.263715][    C1] usbtmc 5-1:0.0: unknown status received: -71
[  370.269819][    C0] usbtmc 2-1:0.0: unknown status received: -71
[  370.275974][    C1] usbtmc 3-1:0.0: unknown status received: -71
[  370.282100][    C0] usbtmc 6-1:0.0: unknown status received: -71
[  370.288262][    C1] usbtmc 5-1:0.0: unknown status received: -71
[  370.294399][    C0] usbtmc 4-1:0.0: unknown status received: -71



Content provided within this e-mail including any attachments, is for the use of the intended recipients and may contain Rohde & Schwarz company restricted information. Any unauthorized use, disclosure, or distribution of this communication in whole or in part is strictly prohibited. If you are not the intended recipient, please notify the sender by reply email or by telephone and delete the communication in its entirety.
