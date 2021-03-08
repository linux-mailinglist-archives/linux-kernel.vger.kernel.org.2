Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D453315A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCHSO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCHSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:14:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E050C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 10:14:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n17so1701292plc.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 10:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=BMzfJiSNckr4c5bJM9oyPQFJf7z3QvS6eYTHskXsafM=;
        b=DpdsAgQaHmv2JAOZ+bhP4sp1RBYFsEYq+SSfL2bHCxvx4Oa+1ey6LCvKTUtsJX7Hnp
         hxHAmGtQTiskkXfkKXpXdazG70wERIFgteI6y6U5Fs9wDN8wvPnMrJerRQutlJJLEaRV
         2ldo+mTCwY3AdiYz6eHD8OhGUuAQFFTvGFRUty6qE5zy2vLNxlNfv9WjSjWWr2/afs5v
         wWGxPAcQJ/z+ygYio+jqXC3w+rSbJ5EV4g3Mjk2pYiIKza25EBc6YM+pjjFNZ9MRfjN0
         VzijfTuc+xxMtHYB1ynPtu1wbl/5e7/MM7MVoXYmHpgouhMgUyp5yaiRPeoktmQMtabo
         N6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=BMzfJiSNckr4c5bJM9oyPQFJf7z3QvS6eYTHskXsafM=;
        b=Wls5l0tE+VEQOTj0FSbgwB+qz80vT2yQILuLcHnVHliYw2DTltzMBTG9QC8xoXZEQ+
         ep0Ooml+uP5/EHbYTSZIxSJ9E5hQh1Tvt+dIyZcxYF64lZgc7PiBCM9r57OkcZ3XdmfW
         hiILu0rkEK5KJeLa9Rp8vAF9sLx6BRNsL1TGRf2IJVvfppbMvBJzuRuQ4CJRRAsMmeR+
         bkvGw0tbb3qXz7Rz1UmGdRbmiFR5KAxRfWvgDU38HJxmbJjiwJ5liwRri/qWao46dcy4
         iUxDimN79ndjoV25iqXMQh6xGToPDHIyFebSLTA6lBoOSSv5M3jDIeA6Z8r4bVIqFpEu
         BBHg==
X-Gm-Message-State: AOAM530//rhUaE3iDCI7ap5mJo5XLQkn2HCI1/LQ0wITJ4ShKE8oECIE
        H0nNEDgLBATemp4UcDSiRiHL6g==
X-Google-Smtp-Source: ABdhPJwz39/p7xj03gR2pGest2ZPugtBXlw5U3YPRRZUCmiPLFttiRa/JNLUKm+korjrZ+RdYKPd0Q==
X-Received: by 2002:a17:90a:4894:: with SMTP id b20mr143836pjh.50.1615227286141;
        Mon, 08 Mar 2021 10:14:46 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:691e:92d:1e16:d5b3? ([2601:646:c200:1ef2:691e:92d:1e16:d5b3])
        by smtp.gmail.com with ESMTPSA id k27sm11567445pfg.95.2021.03.08.10.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 10:14:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for hwpoison page access.
Date:   Mon, 8 Mar 2021 10:14:44 -0800
Message-Id: <8F3F763F-59CC-4E25-B4DE-89CD0632F754@amacapital.net>
References: <20210308174912.4ac9029a@alex-virtual-machine>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        yangfeng1@kingsoft.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20210308174912.4ac9029a@alex-virtual-machine>
To:     Aili Yao <yaoaili@kingsoft.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 8, 2021, at 1:49 AM, Aili Yao <yaoaili@kingsoft.com> wrote:
>=20
> =EF=BB=BFOn Sun, 7 Mar 2021 11:16:24 -0800
> Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>>>>>>> Some programs may use read(2), write(2), etc as ways to check if
>>>>>>> memory is valid without getting a signal.  They might not want
>>>>>>> signals, which means that this feature might need to be configurable=
. =20
>>>>>>=20
>>>>>> That sounds like an appalling hack. If users need such a mechanism
>>>>>> we should create some better way to do that.
>>>>>>=20
>>>>>=20
>>>>> Appalling hack or not, it works. So, if we=E2=80=99re going to send a s=
ignal to user code that looks like it originated from a bina fide architectu=
ral recoverable fault, it needs to be recoverable.  A load from a failed NVD=
IMM page is such a fault. A *kernel* load is not. So we need to distinguish i=
t somehow. =20
>>>>=20
>>>> Sorry for my previous mis-understanding, and i have some questions:
>>>> if programs use read,write to check if if memory is valid, does it real=
ly want to cover the poison case? =20
>>=20
>> I don't know.
>>=20
>>>> When for such a case, an error is returned,  can the program realize it=
's hwposion issue not other software error and process correctly? =20
>>=20
>> Again, I don't know.  But changing the API like this seems potentialy
>> dangerous and needs to be done with care.
>>=20
>>>>=20
>>>> if this is the proper action, the original posion flow in current code f=
rom read and write need to change too.
>>>>=20
>>>=20
>>> Sorry, another question:
>>>  When programs use read(2), write(2) as ways to check if memory is valid=
, does it really want to check if the user page the program provided is vali=
d, not the destination or disk space valid? =20
>>=20
>> They may well be trying to see if their memory is valid.
>=20
> Thanks for your reply, and I don't know what to do.
> For current code, if user program write to a block device(maybe a test try=
) and if its user copy page corrupt when in kernel copy, the process is kill=
ed with a SIGBUS.
> And for the page fault case in this thread, the process is error returned.=


Can you point me at that SIGBUS code in a current kernel?

>=20
> --=20
> Thanks!
> Aili Yao
