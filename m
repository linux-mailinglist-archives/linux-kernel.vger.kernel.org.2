Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97734393894
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 00:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhE0WNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 18:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhE0WNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 18:13:32 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB841C061574;
        Thu, 27 May 2021 15:11:57 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso1667453otu.10;
        Thu, 27 May 2021 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z9JmRUMI4ldGXsbkG6Shn3CZrfrj0MrU8srTAZhggEY=;
        b=GeC2XLOaxfwcDMbnI0WwX55FjX31WbjIppCZ+K0vVzagM26/W3bv4tA0Ndtm1ktGxg
         U313AHhwimwQxCKkQM6ugdT0T+jXHmD5MPvI5lAXa0BCQ5KPqSc/77FQ0+EgNOFEJ/fH
         Un2O1d9+HlyeoUW9pueff7VCVSGovR8hgvst1zS9XVIF4SIJKCP+arnxMPjVFyCnqCCM
         b+augjk2DR5WLLr7PkciQTT9W2g8npxd39JK4Ic7noNRqyGAK9vLEYs35UVOZ1wPlInq
         mmtO5RBK9vzMHxavl8g33KTBBBdsbLOl9ObQupPvOjRLZHPHYXkXIHivmqsK80lkhJQg
         SPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Z9JmRUMI4ldGXsbkG6Shn3CZrfrj0MrU8srTAZhggEY=;
        b=M6BIPEJrsmkOFCn6eNRcYDzc2erXadC9VVOvut2FoafcO9lQnXRi90eL+Gj++2L0mc
         SJJPoaWdqfKUjS3FvYFoq9GM20xB/ZN5lecZGoBAY0DqDsZN8wdDZ5UgxU7ixiDZuANx
         yW9XMGrHDMYJ95D+3AD1DRqnAfT/7uBzLh9F36EPaF8SojqWD6z+hMxDYWb9eB8lwcSr
         8xqKXmULny73N9s0qAvB1voF0pnyN0S9EkRlHaG27+wy9dsmQJdwVT3GnszuSQKv6D8C
         9YCtmlqe8qhwL8GQZZz3wBr3yAegIqk41aK7R6WuvqogTwW0ptG0v1b1mPJ71oVHrW25
         uULQ==
X-Gm-Message-State: AOAM533FpLSOdPnBHBxVO01xj8xFz6FZtAPkbxv+C8dp0C8LldtQ/Jg9
        R/d022cXekq2w3BNnqLsa5Y=
X-Google-Smtp-Source: ABdhPJywe3CKFp04eL+q1Dbq4cCeqr8y6B8ZQpzseGnbnaFQs1yQI3W/yfS48T5d9TjaW4hO1ifR6A==
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr4432514otq.247.1622153517234;
        Thu, 27 May 2021 15:11:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k21sm741108otr.3.2021.05.27.15.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 15:11:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 27 May 2021 15:11:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
Message-ID: <20210527221155.GA3461420@roeck-us.net>
References: <CA+HBbNGBirE=Po7q5eUeHho0rBATa_ApWLiU_oPXsGN+6U9U+g@mail.gmail.com>
 <CA+HBbNGZ1axZpRy5UwQP_4eZCA32eyPJVcj6xN4i8AhOQMYeTA@mail.gmail.com>
 <493e4da4-8f2b-9856-b538-6e95e3766d5e@roeck-us.net>
 <CA+HBbNHspA5cZJSHJkLpnP+UODGy7w5i8mKP2NH9JALQ1RqQ_w@mail.gmail.com>
 <7af2d708-7e22-3970-7bf8-1cb23317cb55@roeck-us.net>
 <CA+HBbNFVKYPAPKkGJiRhW4VmEGX=da8QALNwbVA1gGegF6KPkQ@mail.gmail.com>
 <2ba03d58-a4de-b683-6169-3f12482aa29e@roeck-us.net>
 <CA+HBbNHp2-a-zgUKRLUQVLcs4qcUim=_75YgVZApH1hRrAaP6w@mail.gmail.com>
 <20210527192657.GA3454023@roeck-us.net>
 <CA+HBbNHsgS_ZTf5_n0LDSv=6ztUHJ4sweWJL7=AGeR5nhu6Zrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNHsgS_ZTf5_n0LDSv=6ztUHJ4sweWJL7=AGeR5nhu6Zrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 09:43:33PM +0200, Robert Marko wrote:
[ ... ]
> 
> I can confirm that this does indeed enable block reads and
> i2c_smbus_read_block_data()
> works now.
> 

Follow-up:

> > +static void
> > +mv64xxx_i2c_do_read_data(struct mv64xxx_i2c_data *drv_data)
> > +{
> > +       u8 data;
> > +
> > +       data = readl(drv_data->reg_base + drv_data->reg_offsets.data);
> > +       drv_data->msg->buf[drv_data->byte_posn++] = data;
> > +
> > +       if (drv_data->msg->flags & I2C_M_RECV_LEN) {
> > +               if (!data || data > I2C_SMBUS_BLOCK_MAX) {
> > +                       /*
> > +                        * FIXME
> > +                        * Abort and report error. Needs to be
> > +                        * verified/tested on real hardware.
> > +                        */
> > +                       drv_data->rc = -EPROTO;
> > +                       mv64xxx_i2c_do_send_stop(drv_data);
> > +                       return;

Can you possibly test if this works ? Trying a block read on
any register which returns 0 or > 32 as first byte should do.

Thanks,
Guenter
