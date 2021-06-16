Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59023A949E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhFPIDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhFPIDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:03:13 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D45C061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:01:06 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso1640326otu.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zKbBM3dar0z9KtiIw9VPBWLRm0PXYT0oXsVyvqC2rv0=;
        b=rY+7R0n+snOz2Ygl3mNrIna/LciOo99+D5etRRjzkCRAWs2885DeBJ8DXFgxD7Oe7p
         afwumYSYUFGE1zkmiAugkhT27n5HlSelP4iyMG3PkX+hz86gEzoW03zhWqvurfpVzu0J
         P+Xb41wDA+86Ld9hhyH3zU7KF4UCwSYhDQZW/SHadl0J06NmuyCMdDAn769FXVHhnKe2
         NeN6qAlkgpVjSEBPIx27ru97au7ST1hr4KhGcfcfCx4rbVO5PVV9Ry8waaza+E3JZAez
         GVpH8qDCY55NjDpboz37u8XtvB9CwLvIa3cIoQ2/MWifdL5dyft1y3o8KaG+Iptgx8DU
         dYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zKbBM3dar0z9KtiIw9VPBWLRm0PXYT0oXsVyvqC2rv0=;
        b=fAgaOpkOdmifWA1DR9nV21VOOr4uuGMr5MAqtjwmKt7LiAHkQFgOIuw72aorvPkPmY
         h5mkRDOcewUfPBtw+d4U1wNUDd+zepbxOjzov7khPCn2BkSkb9iIzgA7kbqyWMEV5uU2
         1TDQMi6avkQpg8fxyTFPepe+CcQQmFNYiGgqQ/yfYdz+ucn09gHTXEiZfjbfoBjlhp3O
         CkvcjVCwpQX5yNSl84rgrRZGokr0t1XCsduDY+V9cLzgkJO+anM4PanIXgu8KfPZgqSb
         CfAuyU82Sz2AioQps1lCXBrUORrzja5DI6edO5tF1uvcbagvdMvkD+meOhNziahMVFGb
         kBkQ==
X-Gm-Message-State: AOAM53295X4XnO4fLy+dCEy8nIijeiqSR1rshJLGEWtbjrl6IZ1LULBD
        rcAotBrDlKRWLtgvbt8YlEBN4PpHlUF9elML+10gv94/
X-Google-Smtp-Source: ABdhPJyfnItnKlY3++wesx21jATGtxruPjLGHqpTZC1Ew3PN2AnhH+XKTkUfH+SgvNmVf/7NEyPmGqOTvwKv8Ubw8Kc=
X-Received: by 2002:a9d:748e:: with SMTP id t14mr2846291otk.354.1623830465764;
 Wed, 16 Jun 2021 01:01:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:33b2:0:0:0:0:0 with HTTP; Wed, 16 Jun 2021 01:01:05
 -0700 (PDT)
In-Reply-To: <e4511265-485c-915c-4567-930b658f7c0e@kernel.org>
References: <1623812199-31866-1-git-send-email-zhenguo6858@gmail.com>
 <YMmYD3rkS8o+1dXr@kroah.com> <CAGGV+3JjiuAoXefUwpekbcqB_Xye32xQSMK0jKQ_zNM6dvOPAw@mail.gmail.com>
 <YMmqsJ3xwIIxzop+@kroah.com> <e4511265-485c-915c-4567-930b658f7c0e@kernel.org>
From:   =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Date:   Wed, 16 Jun 2021 16:01:05 +0800
Message-ID: <CAGGV+3LhweM+=42yG3N4mSuDfbJY7xsJ0PgBNFP2HPtcskDHyg@mail.gmail.com>
Subject: Re: [PATCH] tty: n_gsm: Fix CR bit value when initiator=0
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear gregkh=EF=BC=8CJiri

I think that linux ngsm is cp cmux function  (config
slaver,c.initiator =3D 0),pc side or ubuntu or terminal will send
"AT+CMUX" by tty dev, and send SABM.DISC.CLD command=E3=80=82

because project is YOCTO,YOCTO  is IOT open project,need config
slaver=EF=BC=8Cafter config =E2=80=9Cc.initiator =3D 0=E2=80=9D=EF=BC=8Cngs=
m can=E2=80=98t work normally.


slaver config ,it doesn't need to send "AT+CMUX"
----------------------------------------------------------
2.1 switch the serial line to using the n_gsm line discipline by using
    TIOCSETD ioctl.
2.2 configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl.
2.3 obtain base gsmtty number for the used serial port,

  #include <stdio.h>
  #include <stdint.h>
  #include <linux/gsmmux.h>
  #include <linux/tty.h>
  #define DEFAULT_SPEED B115200
  #define SERIAL_PORT   /dev/ttyS0

    int ldisc =3D N_GSM0710;
    struct gsm_config c;
    struct termios configuration;
    uint32_t first;

    /* open the serial port */
    fd =3D open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);

    /* configure the serial port : speed, flow control ... */

    /* use n_gsm line discipline */
    ioctl(fd, TIOCSETD, &ldisc);

    /* get n_gsm configuration */
    ioctl(fd, GSMIOC_GETCONF, &c);
    /* we are responter and need encoding 0 (basic) */
    c.initiator =3D 0;
    c.encapsulation =3D 0;
    /* our modem defaults to a maximum size of 127 bytes */
    c.mru =3D 127;
    c.mtu =3D 127;
    /* set the new configuration */
    ioctl(fd, GSMIOC_SETCONF, &c);
    /* get first gsmtty device node */
    ioctl(fd, GSMIOC_GETFIRST, &first);
    printf("first muxed line: /dev/gsmtty%i\n", first);

    /* and wait for ever to keep the line discipline enabled */
    daemon(0,0);
    pause();


2021-06-16 15:45 GMT+08:00, Jiri Slaby <jirislaby@kernel.org>:
> On 16. 06. 21, 9:39, Greg KH wrote:
>>
>> A: http://en.wikipedia.org/wiki/Top_post
>> Q: Were do I find info about this thing called top-posting?
>> A: Because it messes up the order in which people normally read text.
>> Q: Why is top-posting such a bad thing?
>> A: Top-posting.
>> Q: What is the most annoying thing in e-mail?
>>
>> A: No.
>> Q: Should I include quotations after my reply?
>>
>> http://daringfireball.net/2007/07/on_top
>>
>> On Wed, Jun 16, 2021 at 03:29:11PM +0800, =E8=B5=B5=E6=8C=AF=E5=9B=BD wr=
ote:
>>> Dear gregkh
>>>
>>> 1:  Documentation/driver-api/serial/n_gsm.rst
>>>
>>> The text introduces the config of master ( c.initiator =3D 1), but the
>>> config of as responder is different.
>>> when set gsm->initiator=3D0 by GSMIOC_SETCONF ,ngsm driver should be
>>> responder(slaver)
>>>
>>> config=EF=BC=9A
>>> 	c.initiator =3D 0;    // set initiator=3D0=EF=BC=8Cngsm as responder
>>> 	ioctl(fd, GSMIOC_SETCONF, &c);
>>>
>>> 2:  if master side send SABM/DISC frame data by uart dev
>>>      DLC0 control data frame:f9 03 3f 01 1c f9
>>>      kernel log=EF=BC=9A gsmld_receive: 00000000: f9 03 3f 01 1c f9
>>>
>>> {
>>> 	cr =3D gsm->address & 1;		/* C/R bit */
>>> //CR value=3D1
>>>
>>> 	gsm_print_packet("<--", address, cr, gsm->control, gsm->buf, gsm->len)=
;
>>>
>>> 	cr ^=3D 1 - gsm->initiator;	/* Flip so 1 always means command */
>>> //when gsm->initiator is 0, CR value=3D0 by "^=3D" calculation
>>> 	dlci =3D gsm->dlci[address];
>>>
>>> 	switch (gsm->control) {
>>> 	case SABM|PF:
>>> 		if (cr =3D=3D 0)
>>> 			goto invalid;                       //if CR value=3D0,ngsm will goto
>>> invalid,but the dlc0 control frame data is right,if we can't modify
>>> ,ngsm can't send UA response data
>>> }
>>
>> I am sorry, but I really do not understand what you are saying here.
>> Please resubmit your patch with an updated changelog that explains why
>> this change is needed and what it does.
>
> And why it was able to work until now. I.e. isn't the Documentation wrong=
?
>
> thanks,
> --
> js
> suse labs
>
