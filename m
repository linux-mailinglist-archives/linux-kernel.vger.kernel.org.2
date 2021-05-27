Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD903937BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 23:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhE0VDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 17:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhE0VDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 17:03:20 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4FFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:01:47 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c2so1469555ilo.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5k+QoYElPvv/JEIJG27i2r98ODrDTXojL8bBx2Ub4FU=;
        b=BUozctgwF93n24U0ffApDB78imp2Sksep1yrBASZyXgVCWWSl3usAYapuhoUUReR41
         /weePwO8Vhgj5Y68w7lcQ5ErFW+gQzwVL38U6pmYBGyWRz5raYcZu3bOSf3hlyw8TPhD
         SShyZFspCKH3CHwLPl86qYQ8OoGV10Ww3wlN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5k+QoYElPvv/JEIJG27i2r98ODrDTXojL8bBx2Ub4FU=;
        b=K0ONOvywnu9WcBg/9t6W5/XuQ/HURBJ7+NfqhVjXFKsLf1wzmWoCMBXsbyhuOuxqGW
         jP/GVvpYMAXn9ftMVx36Vb5sNgHeVctC3pwNuq+tRfmETqbvgWDZyByENjxBIppW47Ws
         bucpZ0vrM/gPHyfVXInujgeNJcMsOsqs0V9V5Xq8wGMkdQ+2GGn1MYCZRwwE4zMicFEy
         gB+bBNqmhOGmIpT/s/3SLvDpMh0gXdiJHgiN/0WK0K/Aw7pFcHjA37K4X3u6oko/XZwv
         0rEDEXekRWawjagorvwv/0BaIt8xqTdRjzdw0m55/+9LvGy+1dSEKQrzBnxe1XmC/Qfk
         ZhYQ==
X-Gm-Message-State: AOAM530h1vAMCMBRR7Gx+0otz6AeHFxy3YDFmeH25hTGUs6tHAKmsHvi
        gqq0bzWRCnokwMD1iT3Z5FhvcgEM8nPduSwOHZxQUw==
X-Google-Smtp-Source: ABdhPJwoUZ3bji3NPjrdYGFjbYhXHgp0WBlB2r3lRKucT3PYjXiMnvg71VMZWXk/iiu7DtlSAMyuC8B7VBd5ltmCwuc=
X-Received: by 2002:a92:dc45:: with SMTP id x5mr4174288ilq.95.1622149306562;
 Thu, 27 May 2021 14:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210405202857.1265308-1-gwendal@google.com>
In-Reply-To: <20210405202857.1265308-1-gwendal@google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 27 May 2021 14:01:34 -0700
Message-ID: <CAPUE2uvZzXUoG+Fr7c3q0ysMUz0eb36PrdknG37FkG1v2h7zUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] platform/chrome: Update cros_ec sysfs attribute
 after sensors are found
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+dtor]
Is this change acceptable? I was worried it could break when
asynchronous probing is used [https://lwn.net/Articles/629895/], but
since all probes are deferred in a single thread, it is safe.
Gwendal.


Gwendal.

On Mon, Apr 5, 2021 at 1:29 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Attribute "kb_wake_angle" in /sys/<cros_ec hw path>/chromeos/cros_ec,
> used to set at which angle the embedded controller must wake up the
> host, is only set when there is at least 2 accelerometers in the
> chromebook.
>
> The detection of these sensors is done in cros_ec_sensorhub, driver that
> can be probed after the cros_ec_sysfs driver that sets the attribute.
> Therefore, we need to upgrade the cros_ec sysfs groups in the sensorhub
> probe routine.
>
> The first patch cleans up cros_ec_sysfs by using .dev_groups driver
> field, the second patch fixes the problem.
>
> Gwendal Grignou (2):
>   platform/chrome: Use dev_groups to set device sysfs attributes
>   platform/chrome: Update cros_ec sysfs attributes on sensors discovery
>
>  drivers/platform/chrome/cros_ec_sensorhub.c |  5 ++++-
>  drivers/platform/chrome/cros_ec_sysfs.c     | 22 +++++++--------------
>  include/linux/platform_data/cros_ec_proto.h |  2 ++
>  3 files changed, 13 insertions(+), 16 deletions(-)
>
> --
> 2.31.0.208.g409f899ff0-goog
>
