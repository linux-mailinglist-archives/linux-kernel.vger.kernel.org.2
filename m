Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785B33C95E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 04:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhGOCc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 22:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhGOCc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 22:32:56 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94287C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 19:30:04 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w194so4736367oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 19:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zsHOwqmd3gVtSyPvrq3bj+t+QcLk1cjJ97mnMG1JuTQ=;
        b=P/paEghrn7R0+4aEZbs+8fP+9UYyjwthyOYqnQLyk5i5mNMUuDUtynTPXNn9U0W9ZS
         FiGN+H9hknurhKNTqys+eQH4yKWddMMUyJaHXm5jRxFLxgrnfpwxTnUoXYM/v67fGfZY
         dRzRis0mgQiPJhT3XbhW0tmW5U/0wu8thkSJJCyJKYtRmsncfAHQO4gzeElhysfJI8QD
         OUr5XdOOwaS5Rth74mXV48nrkosXXbGg6UG+Ig2Ngo7SVXrohs5VYXRc8rhyxyB40FYI
         6OsXvlTArCH1o7qegZ1JFAg4RRd6jt3G6ThD8SAjD8SUs6Ypu+Xot5hLknFKtgUGn7vR
         T/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zsHOwqmd3gVtSyPvrq3bj+t+QcLk1cjJ97mnMG1JuTQ=;
        b=sPqifc4Po/vEUTxR5mRcVJc4A5DQ52SNOtj2bKgVl5lYs7HcXmABCg7a5Ar/rJDN2j
         8dpwc9Cs3jRiEu3B2yBnVhk/i9mjQX9bGXilf24wdWTcoXlqXN0gMK2x5DZBujziyGDd
         q4GG4FgqdAAN2UlIE8kxGFwqrLO1qCtqld2eegqg0MOlI3LHYRIT6B6s4g24Q9NTiIzt
         UJ2/hWiJ+TapbAwNnlirP35zfBz1jipCpjaRAzXX0xi0ClpNR40plf1Ibhu28B9TPwuo
         vx5vPYA44EJyUtZBNmOCbwALyntQCNbm1OF//5vbBdV2BeAQw9zPUl9nr795PXijVl6/
         B5Qg==
X-Gm-Message-State: AOAM532mrQBE+WMdn6dcQwPAbOwI2vdRyIA/2+8vXU6ElvImc0leIsLe
        WRZtCpJN/6eLPReMQtRBLbxWonJMVSnA45sFPDg=
X-Google-Smtp-Source: ABdhPJx5BcEy/tgdpmACYEzaVSWRMuBot7n5L335EUTu4qlSGPPHJQcO7n++gn6M6sjpPDxyzkhHi09zbR+7cF/Njuw=
X-Received: by 2002:a05:6808:210e:: with SMTP id r14mr789609oiw.90.1626316203958;
 Wed, 14 Jul 2021 19:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <1623844402-4731-1-git-send-email-zhenguo6858@gmail.com> <CAGGV+3+5g_DbBvjT+EqEGaaLv2-50hrpr5dZSF+SyH8gvzs6RQ@mail.gmail.com>
In-Reply-To: <CAGGV+3+5g_DbBvjT+EqEGaaLv2-50hrpr5dZSF+SyH8gvzs6RQ@mail.gmail.com>
From:   =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Date:   Thu, 15 Jul 2021 10:29:36 +0800
Message-ID: <CAGGV+3K_ctHMY=s-1RToPgiQBdrVGPRqJ5SeWRzfY_dDM+5mXw@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: CR bit value should be 0 when config "initiator=0"
To:     =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jiri,Greg

ngsm as responser=EF=BC=8Cpls review the process again.
because according to this process, it can't work.

Thanks!

=E8=B5=B5=E6=8C=AF=E5=9B=BD <zhenguo6858@gmail.com> =E4=BA=8E2021=E5=B9=B47=
=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:12=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Dear Jiri,Greg
>
>  1:   our development board uses linux kernel , uart dev node is "/dev/tt=
yGS2"
>  2:   config uart "/dev/ttyGS2" ,we use ngsm ldisc,and config
> "c.initiator =3D 0;" code is as follows
>
>   #include <stdio.h>
>   #include <stdint.h>
>   #include <linux/gsmmux.h>
>   #include <linux/tty.h>
>   #define DEFAULT_SPEED      B115200
>   #define SERIAL_PORT        /dev/ttyGS2
>
>      int ldisc =3D N_GSM0710;
>      struct gsm_config c;
>      struct termios configuration;
>      uint32_t first;
>
>      /* open the serial port */
>      fd =3D open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
>
>      /* configure the serial port : speed, flow control ... */
>
>      /* use n_gsm line discipline */
>      ioctl(fd, TIOCSETD, &ldisc);
>
>      /* get n_gsm configuration */
>      ioctl(fd, GSMIOC_GETCONF, &c);
>      /* we are responter and need encoding 0 (basic) */
>      c.initiator =3D 0;
>      c.encapsulation =3D 0;
>      /* our modem defaults to a maximum size of 127 bytes */
>      c.mru =3D 127;
>      c.mtu =3D 127;
>     /* set the new configuration */
>      ioctl(fd, GSMIOC_SETCONF, &c);
>      /* get first gsmtty device node */
>      ioctl(fd, GSMIOC_GETFIRST, &first);
>      printf("first muxed line: /dev/gsmtty%i\n", first);
>
>      /* and wait for ever to keep the line discipline enabled */
>      daemon(0,0);
>      pause();
>
> 3:  connect to ubuntu by uart serial port cable,ubuntu uart dev node
> is /"dev/ttyUSB0"
> send  DLC0 SABM command by "/dev/ttyUSB0",but linux development board
> can't response,code is as follows
>
> int main(int argc, char **argv)
> {
>     int fd;
> fd =3D open("/dev/ttyUSB0,O_RDWR | O_NOCTTY | O_NDELAY);
> char buf[256]=3D{0xf9,0x03,0x3f,0x01,0x1c,0xf9};
> write(fd,buf,6);
> close(fd);
> }
>
> 4:  linux development board receive data,by uart,gsm_queue will check
> CR,find CR=3D1.so go to invalid,pls check again.
> static void gsm_queue(struct gsm_mux *gsm)
> {
> cr ^=3D 1 - gsm->initiator; /* Flip so 1 always means command */
> dlci =3D gsm->dlci[address];
>
> switch (gsm->control) {
> case SABM|PF:
> if (cr =3D=3D 0)
> goto invalid;
> if (dlci =3D=3D NULL)
> dlci =3D gsm_dlci_alloc(gsm, address);
> if (dlci =3D=3D NULL)
> return;
> if (dlci->dead)
> gsm_response(gsm, address, DM);
> else {
> gsm_response(gsm, address, UA);
> gsm_dlci_open(dlci);
> }
> break;
