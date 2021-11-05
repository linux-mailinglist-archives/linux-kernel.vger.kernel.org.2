Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3C5446557
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhKEPCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:02:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:48445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233344AbhKEPCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636124353;
        bh=rTZyr90F33UIxLT2rfkTze3Dx3P4fW7zLUDyWI7/ts4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dxIr5giVrgHWCMHcPIkRVfFseDrweAo/gGxpbdLHAFzMO1S/qoYAl7eTwmKkI4Zla
         dhHFVm4FriE4PQatxsvVyMFgCYPRRRwouSF+DUTIQn3LxRPFEUeH2Is3zeyiY5TJ1L
         VhG/RxCRZvZ5qvJ525BXURVU01EcMkQ9vstHwm8o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.252] ([5.166.175.137]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdvmY-1m9OQ23QPe-00b78d; Fri, 05
 Nov 2021 15:59:12 +0100
Message-ID: <10ed7b49-fd66-68c7-5533-866c2ea27ddb@gmx.com>
Date:   Fri, 5 Nov 2021 14:59:11 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using
 bugzilla.kernel.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20210110121033.130504-1-linux@leemhuis.info>
 <6abc7248-efda-b569-9030-5384e5ce1f29@gmx.com>
 <YYVC6Nd+XjG6shDV@casper.infradead.org>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <YYVC6Nd+XjG6shDV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:18FimqYHz03+t3Osu8rgaYFfIygFQ7fi9zFJdfzEHD6rSwti+Wd
 BviphiGw0Ycj+ZwdwffgfUL25sqiA7PuN5OpsJ6ByyWixTI1C1BdRnptUIqk6U8bEc4DhHD
 W4L1D6tXaBgNXQqmfvPglbBJGyWvPnX4C2JqRTJN+57lsgWHVy2WOjPv3jM8oMAGBkvSqPX
 RX8lZO4S+mZfegxLnmgNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7q0tcp2KL34=:CNiu6UFq6mvvSrRGKYsCM7
 /LUdigkclRC1TQbtUjGSdRrznLvZrbZ4KDOekQSOvRVGBWOsIvgKwafJZ6c4+iE/Cg541agh6
 6D4T0wcseNTxdwLNaE8zeYBmBm6ENOXOKJHMvKsD49jhTa1Y03LIE8hPHnWaNCcec8DSOs33h
 FKykfuO8ALI7PItErLWdcxQJs5+v4npV4/+3/kfbKOg8ALu9A9srLLfy8JiqBR7uLYz88zBiF
 po028MDfav8wIQMLNFUdPRZ8PKSC2SNSfNQDzt8S3hsKqpAIm5ZSYBoA6lFizDbUhE4gPplGD
 H2csnGmqWcKTMWseKQu/bOQYX7isAmylnaH8xkOWzhYHKwB3u2HzRP14xu1DL6mg4vQJqaqWI
 lmekvx0QLxe6R5zx3K6VNDKjx51DUfcNY5O9jB4r0vWxUsWJ9dver2OXsdoqAGoNJ0Iw/nIBU
 EQfLMazUDWOQtCcOtXVwt6tEx482oP3EKz+uZZKIBGEOC+xRzERJp5Nw+UYY/PCZf/j1K+h5x
 TnDPfnmZeuePqCtnhCgz/k150ut92IU8ei08FtbXFj6X1LjAI39PS88L0wFeUVhCyFGdu8UTH
 H8lg/yHbr/b2HfSQULbsescPMlRkPx2VCcpeWrZ08hrlHMsupzpv8GFSO2jsb36pl5KChujs7
 DpwEUb/OVGMOIqu3Dj4poLUW3UfcTd6r9KGk5PzmdLAnF4eGBvG9e+DHZLBrf4Tm+a1qLgFt+
 ex28vXnj4TRUJ1fS8+PG7jMAgbiJaNWeuRx0Y6Pgixiti66mIY9wTaeNoyEP3w0mRNHrqHEYz
 Q7uHejLEPNhSK3TDl7+IiC4Sw7smyvTpRFOqTBQRCbjP6npEFuQ9uG86jce5Wa1rdcRAp8uIW
 Eiw0irBaIg0hlTeFztmT0rG7QTSWN9HV9WH6XaWxyEFnTZJXdMwGXxkz2oEGaa1oYQtHVYhz4
 lfaE5VAIIMuh26CWh7qc9kVBGGuN32g/uIlFltghD3vPmbkMlycPBSsVXOPGlxfd7dswaA1o5
 gogd4D9fmlsAZ76BzghDLwmaRdjku2sysalUU9X2TUlinD/ZJgmvmP9VEch7p+z9cw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 14:42, Matthew Wilcox wrote:
> On Fri, Nov 05, 2021 at 02:36:51PM +0000, Artem S. Tashkinov wrote:
>> Hello,
>>
>> Let me express an utter dissatisfaction and even contempt for this prop=
osal.
>
> Thank you for volunteering to take over administration of
> bugzilla.kernel.org.  Can you lay out your plans for making kernel
> developers care about it?
>

Last time I checked the Linux foundation is not exactly living from hand
to mouth and has enough financial backing from major corporations.

Is this really about funding?

Regards,
Artem
