Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF01342D8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhJNMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhJNMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:11:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEBDC061570;
        Thu, 14 Oct 2021 05:09:06 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z69so301150iof.9;
        Thu, 14 Oct 2021 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCQTrZZ2kGrWxHwux+/IHya5iY0hNu6xB10UrKUhFlI=;
        b=Go2QYt+2L/y4KQaD4N641DkAWn8vfuYiVtHJdHMOBrCBYK330BC+e+Cf6dWd+MNufW
         lunEbRzuwmlK/Ud+tgL2jsBDTDQKHs3ZZfkpjfmjCCTyeAtiC77hU1QAJTRr9ea2QTcK
         W0rem47gVL6iCL9lnKGY6xNd1LxPsfA7LSRN9oim+Z9XW8FvDZLefrw+8pyMb71qe//Y
         H0D0cpgQyivywSypjWLkXloevc+w75BQO4+8UBakALVK8hwZJg1IUWsU3noGmhlTXu8f
         5fSD/dZNjvbhfm0wP19VzgtRIHrhIv+ZIo3/pe1k0xY363npAYlVND4tKrOuQZX7hTiG
         IO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCQTrZZ2kGrWxHwux+/IHya5iY0hNu6xB10UrKUhFlI=;
        b=qSZsgeByXd8MPdimoSwCZHM1mp3r3Dhm7vkYhgEYOyhEHjLgk19o2CSy5t3krV9VoN
         0loFAQ0/1Qo4qBrq3L2pJxG0LrhB2ai3ALjoGJmfhufkR/YC9nYE1nprxpEiC5sbJ6ZI
         tLWgcZ7MX17en27+wmIbF23OX1dyJc4J7mZvqaO0Ox4ABrQmwoVlbSIukysjMwWbAXoW
         /W1l/0M2tse7MVgLB8WJCiJL6er/FErZgftxmIdpDeYwzl38bdStFlWtab+1cMQ27NpD
         Tcn7wfq6e107r+mNuKLG3AJ40jMbifYkxLohMoVa9sq9xADM/Bt1KscvEdKLnuO8lY0Y
         5Gfg==
X-Gm-Message-State: AOAM532JEPlTISpldXILTqJuNKj+kM6q+Wq8hhpSV6PIWGormZohIOww
        8j+2SPR+Km6PIzCV5Ksb8l9pHOFodK8NYaw4ttcxph9l
X-Google-Smtp-Source: ABdhPJyyKvNtUCt6v2VbHSK8pHfMZR0n0Nh8t+OSUC44hZM0aHrZVmOD33r4JMG2UBOwtrDuXQvrjFHaoopNuW5ngAw=
X-Received: by 2002:a6b:8dd6:: with SMTP id p205mr2028274iod.192.1634213346294;
 Thu, 14 Oct 2021 05:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211014072537.190816-1-pauk.denis@gmail.com> <20211014072537.190816-2-pauk.denis@gmail.com>
In-Reply-To: <20211014072537.190816-2-pauk.denis@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 14 Oct 2021 14:08:53 +0200
Message-ID: <CAB95QAQQC6KJcbd-WhexBm=jusyoFkkB_a69RizMHpjSEbrqgA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, platform-driver-x86@vger.kernel.org,
        Tor Vic <torvic9@mailbox.org>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct asus_wmi_ec_sensor_address {
> +       u8 index;
> +       u8 bank;
> +       u8 size;
> +};
The fourth field which you removed was supposed to hold the data
encoding type, and together those four were packing nicely in u32...

Eugene
