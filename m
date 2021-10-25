Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B6943973E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhJYNNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhJYNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:13:22 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C8C061745;
        Mon, 25 Oct 2021 06:11:00 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r134so15328287iod.11;
        Mon, 25 Oct 2021 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqSgr0K3Z/r9sP1YQd1U8WeH+I8Nt19Et4qB9zN0QnM=;
        b=gosArYnwumg1N6VgrU3ws2OC+QIQsYC/xRwLyYcspNj5zKaqXy0dBC43yikj/R4SGz
         BWfYXJwxDqX3Z4iIkH36n+902vqYsq5SIo9uv/pNq5VnVaomow+reus8oUl+tVJAS6aN
         Y6aSFMpsr9Xm4mFsqORkCzt8akgjAcQ0XIJciNKrUtEpPxBRKMN4ZfDmSHum4XyKyy7i
         NsBWDzqKMtSdoLgvMktRfOpQ926dhTXFIC1h3Zn9+YmtvsakmIwPNIv8Xz3AXkOaVBx7
         AWUTYKFg9+m9i3gAu7G/pymyZ+CNIZDQlqjx7C3B53D+/ucWX7gH4vh9AfZr5WP1ACCw
         QAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqSgr0K3Z/r9sP1YQd1U8WeH+I8Nt19Et4qB9zN0QnM=;
        b=1iKJONQp4yuo/CUFbg/eL862TWE5wGqnlj9+I1Vqyd8InuIsxhaWYr7B2UkScDghp1
         1kGzcL7I5r4YFBrrFk7Sp3mJJRDKbkEKXcw8iQuDKlMkN9MTjJbBXKh6npZfsPlH0HpR
         6qZnbkG0rUPRPEWXLq0iob318SnQAHhJmz0F/p33aETzQiZGDp0Yv7bJirzcJOwYQAnK
         /sv65PghtTlXuS7kkh4ic4CVPoUWKZr3qWShk/WQ2lcA6WR4jVVAJzL1WOdbc+d4q2wu
         dIjnE2gzRBFwvh1AKInhfobkkR9/GEBj5WMfKK8Wa5LDYPm2ZsiDLZOUPATGWO7xEJ6f
         scuA==
X-Gm-Message-State: AOAM5303rOolnJT0Z7OM2+gAmKDNXCQBSin9brRMCXfSjUDLlEY0GvsF
        LBtfFqN8wMetf5k7qSrwV32Ql96wC61TTNRGpSNnqCuU
X-Google-Smtp-Source: ABdhPJyE2CchchZpEfZkAyrM/PAwt1sP0pvFhVpiTlJ6N/8hbgOMoqp0drlHvQXDnV3C5K5PocsJF5b1ElK8v0a/IgM=
X-Received: by 2002:a6b:8dd6:: with SMTP id p205mr10227210iod.192.1635167459394;
 Mon, 25 Oct 2021 06:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222502.645003-1-pauk.denis@gmail.com> <20211006222502.645003-3-pauk.denis@gmail.com>
 <CAB95QARmjTBVRyru=ZDz9Wc5SX9EPFg7dg6vB+S8=pMtpg8FRw@mail.gmail.com>
 <20211007184644.1d042550@penguin.lxd> <CAB95QASYPRZSFnpE5u=SYJ49Hd+=BAZY==Ky8dzjL8h7YZj-CQ@mail.gmail.com>
 <CAB95QAQ+u4DmF0e9Zvy5hDV0mFQDEULtr-newtz5_6y=Bzp+ww@mail.gmail.com>
 <20211010133921.4277dc79@penguin.lxd> <CAB95QAQs_PUeTU7d9tg83a8hRepjLfLnxVykU2nvBv3Vn49HBQ@mail.gmail.com>
 <8527fb83-4b76-e3c4-85eb-542c1cee249a@roeck-us.net> <CAB95QATwDkGBWdB0YWJovfN=MdtV9JkAWH2ofDFHMVYymStk5w@mail.gmail.com>
In-Reply-To: <CAB95QATwDkGBWdB0YWJovfN=MdtV9JkAWH2ofDFHMVYymStk5w@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Mon, 25 Oct 2021 15:10:48 +0200
Message-ID: <CAB95QASpK+ajGTpJoMTQN1epa-QMy9sJHRPFVyizFgCa3dut=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> On that machine a single reading of the EC register (i.e. a call to
> ec_read()) takes approx. 14 ms. The timeout is probably right here.

I migrated that ASUS machine to another distribution (Arch -> Gentoo,
kernel versions 5.14.8 -> 5.14.14) and surprisingly reading EC
registers became faster. I accumulated data from 14133 read operations
and the times are distributed as follows: 84 % at 4 ms, 10 % at 5 ms,
5.0 % at 6 ms and the rest is between 3 and 9 ms (but concentrating
around multiples of 0.5 ms).

In the meantime the only other user who provided EC read timeouts
showed 14 ms per EC read too.

Regards,
Eugene
