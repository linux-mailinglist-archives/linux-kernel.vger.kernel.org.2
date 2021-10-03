Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1234203F4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhJCUux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhJCUuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 16:50:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076D4C0613EC;
        Sun,  3 Oct 2021 13:49:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m3so62496665lfu.2;
        Sun, 03 Oct 2021 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t9Ux/I6McOf+f8Lkr1OEAW4sbYA9IZDphaHb1oXaHxw=;
        b=N/TInijqXrj+FdLntjPw1iPeJRWuA4uWLooAXGLIvRI+n37J/5Ptba9S/34RHpNZhU
         L/sBpwS8Ai8oKpO9Gatu+b0GK+Xzb1u5+Wg7DoCLEzh4EM6zZSjQzD7sb76dCbww+TUE
         ofQTruXSUDCEC8byaOzkT+eKKiufvDhiQnfZ8Uj5adb9rgdwRBWtVGJhS4bvBhs997XE
         qEpfrRnd1FeAzpI+E2DZNrE5e1d8+EFRJScxUBoC+f3VVX193KTlDnfemCK8g77d+2LU
         tJ4q5ZslZfFICThsGUTfgDq46r8m6A71/zFGkTM9lWh00cQk0QhIyaN3Ksbp0KoQaF++
         AwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t9Ux/I6McOf+f8Lkr1OEAW4sbYA9IZDphaHb1oXaHxw=;
        b=QAxRkZ/QCVd9ENAmh5akuNVSJq/cjY249ji1MoUZ8bAWe0onYZPR+Ku4ITn+qchWo2
         g7wjAi4nKh5IdaFZNelW3w/qSmfAADaqHysyFnbKpp1kKCjvTPugXV/9X+lchS4eCapp
         8KMOBtBAp+APwqT539HPjpIcEAyWNB+g9C9N6WK9shHVYZA5HqEsxmrune9eA810aayo
         f1yT0heDIYcS3iFGZodU7NgtVz8JuE4YeAiKC1Kymq7qHqWIxltOFvPB3iC+UWay3xmz
         CY3/zKlPja4W69F5tZ2oXooNoEM8xXGGS1dmdX6EMBRFhv1noYbDcKd2l0StLq/hiLiQ
         Ucqw==
X-Gm-Message-State: AOAM530I0lGL/21jAgcB61IOEC+Sv0t6qWpayP2/FO2F1D81NS4pWJEp
        hxQC8Ww6x5qnR+EyBARqaEbzQ7i6hCc9XQ==
X-Google-Smtp-Source: ABdhPJyfKt02hKVuG6WVC5Mlice78u7lQ+zN2mN0AkoB9IrcM0PUKGd3c/0EFSrhFX/HGNeQq9d2ag==
X-Received: by 2002:ac2:4c42:: with SMTP id o2mr10692525lfk.504.1633294140227;
        Sun, 03 Oct 2021 13:49:00 -0700 (PDT)
Received: from penguin.lxd (217-15-179-94.pool.ukrtel.net. [94.179.15.217])
        by smtp.gmail.com with ESMTPSA id d27sm1097070lfq.282.2021.10.03.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 13:49:00 -0700 (PDT)
Date:   Sun, 3 Oct 2021 23:48:52 +0300
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (asus_wmi_sensors) Support access via Asus
 WMI.
Message-ID: <20211003234852.213bcd87@penguin.lxd>
In-Reply-To: <CAB95QASk7JGqP2_qLtkb-PXUmKPDMcOvLr_8FLrKpv3S2602mw@mail.gmail.com>
References: <20211002210857.709956-1-pauk.denis@gmail.com>
        <20211002210857.709956-4-pauk.denis@gmail.com>
        <CAB95QASk7JGqP2_qLtkb-PXUmKPDMcOvLr_8FLrKpv3S2602mw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugene,

On Sat, 2 Oct 2021 23:56:20 +0200
Eugene Shalygin <eugene.shalygin@gmail.com> wrote:

> Hi, Denis!
> 
> Thank you for submitting this driver to the mainline! I have a few
> comments/suggestions, please find them below.
> 
> > +#define HWMON_MAX      9  
> 
> There is a hwmon_max enum member, whose current value is 10.
Thank you, I will check.

> 
> > +#define ASUS_WMI_BLOCK_READ_REGISTERS_MAX 0x10 /* from the ASUS
> > DSDT source */ +/* from the ASUS_WMI_BLOCK_READ_REGISTERS_MAX value
> > */ +#define ASUS_WMI_MAX_BUF_LEN 0x80  
> Suggestion:
> #define ASUS_WMI_MAX_BUF_LEN 0x80 /* from the
> ASUS_WMI_BLOCK_READ_REGISTERS_MAX value */
> 
> > +#define ASUSWMI_SENSORS_MAX 11  
> This one is for the EC only, maybe rename it accordingly?
> 
Thank you, I will check.

> > +struct asus_wmi_data {
> > +       int ec_board;
> > +};  
> 
> Duplicates the value in the asus_wmi_sensors struct. Refactoring
> artifact?
>
I have used different structures for data in platform and device.
  
>              asus_wmi_ec_set_sensor_info(si++, "Water", hwmon_fan,
> > +
> > asus_wmi_ec_make_sensor_address(2, 0x00, 0xBC),
> > +                                           &ec->nr_registers);  
> This one is named "W_FLOW" in the BIOS and ASUS software. Maybe append
> "_flow" to the label?
>
Thank you, I will check.
 
> > + * The next four functions converts to/from BRxx string argument
> > format  
> convert (remove "s")
> 
> > +       // assert(len <= 30)  
> Makes little sense in the kernel.
>
Thank you, I will check.
 
> > +static void asus_wmi_ec_make_block_read_query(struct
> > asus_wmi_ec_info *ec) +{
> > +       u16 registers[ASUS_EC_KNOWN_EC_REGISTERS];
> > +       u8 i, j, register_idx = 0;
> > +
> > +       /* if we can get values for all the registers in a single
> > query,
> > +        * the query will not change from call to call
> > +        */
> > +       if (ec->nr_registers <= ASUS_WMI_BLOCK_READ_REGISTERS_MAX &&
> > +           ec->read_arg[0] > 0) {
> > +               /* no need to update */
> > +               return;
> > +       }
> > +  
> I would add a test for ec->nr_registers >
> ASUS_WMI_BLOCK_READ_REGISTERS_MAX and a warning log message here.
>
Thank you, I will check.
 
> > +static int asus_wmi_probe(struct platform_device *pdev)  
> 
> Can we add a module alias or to load the module automatically by other
> means? For module aliases we know DMI parameters for the supported
> boards.
>
I will look, I prefer to reuse same module code for boards with/without
EC endpoints same as in
https://bugzilla.kernel.org/show_bug.cgi?id=204807#c128.

> Best regards,
> Eugene

Best regards,
            Denis.
