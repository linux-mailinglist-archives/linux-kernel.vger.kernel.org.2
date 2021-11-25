Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0628145E19A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 21:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357023AbhKYUdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 15:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357125AbhKYUbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:31:42 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD94C06175B;
        Thu, 25 Nov 2021 12:25:32 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id j18so1391494ljc.12;
        Thu, 25 Nov 2021 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNLFqJ57YVPZ3a374R3MrlUqtQLlCv1arpQuPFGo+aw=;
        b=IzidC0MmI7TwXrODqGg5rPuc7L9qX4qg4B8bchuZqJO5khlksGz479heP0X0EYL7bx
         UvD/x+AM5XegZk17mjCHIwVQ1hcjsx4bsZqm90ItGm/aPPxiD+JkxKYIqMbBIgBL8uXl
         UnrcyHbeoc4Ky3QluGzsy3DpuhPVAPp2RXTZ164Xbs+797jvmMJiiCxZVmV9wCCkSJ71
         T6Cnza6pzYh+KL30ykp1oVOVq2Isbzjc2XHxLk6o15urLFMkMSTLJVSXXIx7axle1BGP
         eij3TCgTbi5RgeQBMwP63PDUuzSkfZy/Bj9qBnozYlRzO5rSHcAXFoC7fsXGoU1CkQjS
         uyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNLFqJ57YVPZ3a374R3MrlUqtQLlCv1arpQuPFGo+aw=;
        b=ITnImD5suvSVHfdfHgMzTeZxVTZfSuKI30o1ve2uQkF4DtXuhjZarrW2OaxrucS1fQ
         5ESxLGrE6DztnL/Hpy3Qx8katk5fWhyJSgt4OtvlGN0vpWtBQIa3SJUv+9e8XywUfKTW
         eW4i+MtgpLzBywHmURU3CRwfGagAJ9Ks2QBm7YXBV+yqE3j54XaZJChrWhDm+1Uu258h
         0DngQztBHf+yDLUYg0bZ/7mkSQ45iDL7RkqnIwUaVY1PQe3szkc6isFUjTXhTRZFsf7W
         oRklqliNX5LpCcaVc9PkDnRIuJALocQrwRZVULute6E08yUzFnSWR33BS3nCIkruX7wR
         ZP6A==
X-Gm-Message-State: AOAM532S4nrQqCfpbynuHPygEpHyARSKpVsgiKvOVY9VsJWLYG7i4/83
        I47i2SScKrPxcAJkKbclJ6liUyX4erZ6Rw==
X-Google-Smtp-Source: ABdhPJxFgrRGyz/0gyv4G1GDRCNhAR9161jYpAdHxvrjHOlEkeMtzN51ZExNLSLETdof4eTaHDz/UA==
X-Received: by 2002:a2e:8e38:: with SMTP id r24mr26290312ljk.450.1637871930437;
        Thu, 25 Nov 2021 12:25:30 -0800 (PST)
Received: from netbook-debian (110-38-179-94.pool.ukrtel.net. [94.179.38.110])
        by smtp.gmail.com with ESMTPSA id b2sm389071lfj.280.2021.11.25.12.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 12:25:30 -0800 (PST)
Date:   Thu, 25 Nov 2021 22:25:26 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI
 mutex.
Message-ID: <20211125222526.405ce775@netbook-debian>
In-Reply-To: <CAHp75Vdi8ujoC5LTYqNmiWe1dTxrYRQKS+YtZE921d-6CZTs=A@mail.gmail.com>
References: <20211122212850.321542-1-pauk.denis@gmail.com>
        <20211122212850.321542-3-pauk.denis@gmail.com>
        <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
        <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
        <CAHp75VeO2mz7wJpuKdrErnYcw-dUOBs9W4FzA6MkgCQLr0eQUg@mail.gmail.com>
        <CAB95QAT_b8Wef+4wN-H8dKZXxgnznqOk5J0fMuL2XJLhob7d9Q@mail.gmail.com>
        <b7616187-87d8-c87f-8f66-d5936a33395f@roeck-us.net>
        <CAB95QAQ2vpXFxZC0G6ogbpk+rDzGMN7N8-RaUX9w_U5bQ1WGMg@mail.gmail.com>
        <CAHp75Vdi8ujoC5LTYqNmiWe1dTxrYRQKS+YtZE921d-6CZTs=A@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Nov 2021 22:09:46 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Nov 25, 2021 at 10:05 PM Eugene Shalygin
> <eugene.shalygin@gmail.com> wrote:
> >
> > On Thu, 25 Nov 2021 at 20:54, Guenter Roeck <linux@roeck-us.net>
> > wrote:  
> > > We won't be heving two drivers with the same functionality. Give
> > > me one reason why I should not drop the wmi driver (or both of
> > > them; I am not sure which one we are talking about here).
> > >
> > > On top of all that, this submission isn't about any of the wmi
> > > drivers, but for the nct6775 driver, which just adds to the
> > > confusion.  
> >
> > Let me try to explain once again, please. I began to dig into the
> > ASUS sensors and how to read their values and at first found the WMI
> > function to do that, wrote a driver and Denis submitted it as
> > asus_wmi_ec_sensors. Now, I know a better and simpler way to read
> > those sensors, which uses ACPI mutex directly. I suggested Denis to
> > use the mutex way for the nct6775 driver for motherboards without
> > WMI functions to read from the nct chip. With that change entering
> > the nct driver, I want to submit my updated driver for EC sensors,
> > replacing the asus_wmi_ec_sensors code (which is essentially my old
> > driver).
> >
> > So, now I ask to rename asus_wmi_sensors to asus_ec_sensors (source
> > file and KBuild options) already before 5.16 is released, because
> > the updated code, which I will submit later, and which will replace
> > that in asus_wmi_ec_sensors.c, does not use WMI.
> >
> > Hope this clarifies my request and intention.  
> 
> Since you are talking about something which is not ready yet (as I
> read "will" above), I propose a compromise variant, i.e. let's leave
> current driver(s) as is for v5.17 and after v5.17-rc1 you submit your
> proposal for review. Okay?
> 

I would like to propose to leave the current name of the driver and add
the same logic as in the current patch. So when we know the exact name
of acpi mutex - code will use such mutex for lock and directly read EC
memory region. In case if we don't know the exact mutex name/path or for
some reason ASUS decides to change UEFI code - code will use WMI
methods. In such a case, adding or checking a new motherboard will
require only adding a minimal list of well known registers without
disassembling UEFI code.   

What do you think?

Best regards,
             Denis.
