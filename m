Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC713BE2F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 08:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhGGGP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 02:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhGGGPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 02:15:55 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6EDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 23:13:14 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u11so2200956oiv.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhjFQjqsGps5ZLlP2FObo/mUu7sdKPBCFwRRv8flp0I=;
        b=fFV29eXG/dIcXGPg5Ky+Joyl3xNLOkue/i5/K2twzWb8FCmN6jU6Z3MF/9IStQ2rKi
         rEMLvPqdaE+hDYdb/rMTNx7EX1N+iCkx9Tqc8Y0Xbb3FGcZBTEkUsoOYs1+HZDj2Bug4
         DtOzOsJWtsn+avPzTdwEUgCQhjqQQGEihfx5MQlTTlPm4eek+NYft0Q4nMjI5kBAbMyI
         C+/C6IrxoK/doS4HgexKloO2rwHOWZcQllIuJ9ldLA5KAiPjRkuXivur3Kxl8SuvKDCl
         hvUMx1+nB76UDTe7DxlG+QOlxEKUNjlqNKnFirs1eGSRfKUAknosA1UVGnt6zO9/xONL
         4+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhjFQjqsGps5ZLlP2FObo/mUu7sdKPBCFwRRv8flp0I=;
        b=lzds6q3woGOTR3lhqHsMudP7qnf91Dl8z7Cths0htRA3JNKSExxN46bmJzu8kfXpjz
         BSRTeZzDLvAFahHRywtJV+FbbreZRz72UeUrdrZATB9LQxL7avnhCyEts94QOlPBydVN
         mWLDrn+nGRQxX6zcL4DULCbVspVvc6/mMLKN4hgtOWTTtKHC4DEiZvYY968MfWkE+rVb
         qSpP2sFU2w1o+6AqetQ0jKySJVXvvx42610luWG0Qw9KXAjVEzNybh6hRYevv/c6QQVL
         ll8WVc0PgZNf3IakKR8wM1PWJGO8eRGhvBs4V07aVTw4H49JrMfvD5W6Ujbh+5OIKoha
         N9vw==
X-Gm-Message-State: AOAM533OWfRZxwyDoj6Vuvt/obDrcML+yVRXfDdJ/efkcUzVJ4EjfG5z
        qxuSxz9yi4ppBdABgdGyA41FjxovlI3F5O9T8RQ=
X-Google-Smtp-Source: ABdhPJxhrqzyLUN1NRFFGZauYnCUCsa8+xyKxE745rIfQ4ZKljhKA4AyenC/0jjN5wzH+JnzbGHVYs/q+oRixSae1vU=
X-Received: by 2002:aca:47c9:: with SMTP id u192mr3587121oia.63.1625638394221;
 Tue, 06 Jul 2021 23:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <1623844402-4731-1-git-send-email-zhenguo6858@gmail.com>
In-Reply-To: <1623844402-4731-1-git-send-email-zhenguo6858@gmail.com>
From:   =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Date:   Wed, 7 Jul 2021 14:12:55 +0800
Message-ID: <CAGGV+3+5g_DbBvjT+EqEGaaLv2-50hrpr5dZSF+SyH8gvzs6RQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: CR bit value should be 0 when config "initiator=0"
To:     =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jiri,Greg

 1:   our development board uses linux kernel , uart dev node is "/dev/ttyGS2"
 2:   config uart "/dev/ttyGS2" ,we use ngsm ldisc,and config
"c.initiator = 0;" code is as follows

  #include <stdio.h>
  #include <stdint.h>
  #include <linux/gsmmux.h>
  #include <linux/tty.h>
  #define DEFAULT_SPEED      B115200
  #define SERIAL_PORT        /dev/ttyGS2

     int ldisc = N_GSM0710;
     struct gsm_config c;
     struct termios configuration;
     uint32_t first;

     /* open the serial port */
     fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);

     /* configure the serial port : speed, flow control ... */

     /* use n_gsm line discipline */
     ioctl(fd, TIOCSETD, &ldisc);

     /* get n_gsm configuration */
     ioctl(fd, GSMIOC_GETCONF, &c);
     /* we are responter and need encoding 0 (basic) */
     c.initiator = 0;
     c.encapsulation = 0;
     /* our modem defaults to a maximum size of 127 bytes */
     c.mru = 127;
     c.mtu = 127;
    /* set the new configuration */
     ioctl(fd, GSMIOC_SETCONF, &c);
     /* get first gsmtty device node */
     ioctl(fd, GSMIOC_GETFIRST, &first);
     printf("first muxed line: /dev/gsmtty%i\n", first);

     /* and wait for ever to keep the line discipline enabled */
     daemon(0,0);
     pause();

3:  connect to ubuntu by uart serial port cable,ubuntu uart dev node
is /"dev/ttyUSB0"
send  DLC0 SABM command by "/dev/ttyUSB0",but linux development board
can't response,code is as follows

int main(int argc, char **argv)
{
    int fd;
fd = open("/dev/ttyUSB0,O_RDWR | O_NOCTTY | O_NDELAY);
char buf[256]={0xf9,0x03,0x3f,0x01,0x1c,0xf9};
write(fd,buf,6);
close(fd);
}

4:  linux development board receive data,by uart,gsm_queue will check
CR,find CR=1.so go to invalid,pls check again.
static void gsm_queue(struct gsm_mux *gsm)
{
cr ^= 1 - gsm->initiator; /* Flip so 1 always means command */
dlci = gsm->dlci[address];

switch (gsm->control) {
case SABM|PF:
if (cr == 0)
goto invalid;
if (dlci == NULL)
dlci = gsm_dlci_alloc(gsm, address);
if (dlci == NULL)
return;
if (dlci->dead)
gsm_response(gsm, address, DM);
else {
gsm_response(gsm, address, UA);
gsm_dlci_open(dlci);
}
break;
