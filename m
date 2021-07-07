Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB5E3BE2F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 08:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGGGLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 02:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhGGGLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 02:11:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD78FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 23:08:59 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so1233160ota.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 23:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhjFQjqsGps5ZLlP2FObo/mUu7sdKPBCFwRRv8flp0I=;
        b=HnHAGY/BGoCWIMjdGWbx+dxNATDMwDxp9FNflMwM6WZ6MW9p6hpHiA+wz0LC9ypuBb
         oaxm0rYPFr1PGlPo0sL2Lz143Cl2gDsSbFJVc653MHvNDhaVhb9evSGpEuCo9aaGSb+u
         Ek0QyCr9gWGACIGZH0AiI/WUmoUaA4WjAOoJspTOa17qKV8RjbHCHbxA7W+nwDnFg0xU
         UMmE29EiHQJqwlT+Ohuq6qD9BtgrpP9juhs3lTBtPki8y8tRDv6FnEK8kUbvgqvIJ/ls
         XJtd3ez7urfWq0ZzY071SN9Rtr2VGFqNBJU6K1xfFEVv7Hl4a8Tb5jd6coqFGZper883
         +vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhjFQjqsGps5ZLlP2FObo/mUu7sdKPBCFwRRv8flp0I=;
        b=rcmqABIFe1vT96T9B1A/nBKq9Tawph1OemUs8FE8tLVCEmyMGoS1sWfctmz97hYhFt
         yAa0HkYxrr1sTzKywM+7HzjiWVONjGO5vN1KszhGm7LtK8py7jyfDLEiQroFgaCuHxYr
         gRGt2/0wam/1XQnEJ2gLThIKQlo7XSvl3czawKIDnDU4gIPms2koTxKbH+yDaimL5TOE
         mBEOlUQE13LazoRWBXJarSFDI22i0IzeX+RX/i2DFOxoqjhcc5NUFijfv/OaOpzKD2oC
         PqMSVVNtwNkaYsWe/vfz1l+LbdCyK4EGYNbHKGUDfcAuTkof7VaUooINk7dh/N376vds
         ofrg==
X-Gm-Message-State: AOAM531swwyutqfzKzPQrNO052x4CMWhplkpB/Xj1yHkND2idyXqzs/v
        l1n5tQlSFTjL3QQ+KcgSjTm1AVAS+XWKLipQl+NOb45DRam2zg==
X-Google-Smtp-Source: ABdhPJzFVujca29EKUrscpso4yd7YoRynU8e+9xXIXLI7nVX0k6Jt7n2M5lc+GaYsVL8MCmdIIgVTfQzeX6rJQjVADg=
X-Received: by 2002:a05:6830:544:: with SMTP id l4mr18151718otb.164.1625638139237;
 Tue, 06 Jul 2021 23:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <1623844402-4731-1-git-send-email-zhenguo6858@gmail.com> <CAGGV+3LgLdohhYhH+qJTokeNU_WdV9oRNHMc9a_5YTTVA3U8ow@mail.gmail.com>
In-Reply-To: <CAGGV+3LgLdohhYhH+qJTokeNU_WdV9oRNHMc9a_5YTTVA3U8ow@mail.gmail.com>
From:   =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
Date:   Wed, 7 Jul 2021 14:08:40 +0800
Message-ID: <CAGGV+3L+VgU75kKt30EoThQ3yhyfFDhkEvoK9N-hAQrv8XxiUA@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: CR bit value should be 0 when config "initiator=0"
To:     =?UTF-8?B?6LW15oyv5Zu9?= <zhenguo6858@gmail.com>
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
