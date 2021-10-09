Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF97F4279F4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 14:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhJIME6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 08:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhJIME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 08:04:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75087C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 05:02:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t9so49320752lfd.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2SmIeY3RvR+sxAopTjlz48utuRp0cXC6WogM9AzM3+w=;
        b=RWuIhFX2NytzmMPip7mieWDbvO63CsBh8wu43qcuEZDcqeFhoXbloJnejuZc5os9rZ
         F/8It8F/SFyRKKUZuCki1R9oqceGh9Kqk8k4zPO3G8XPV8XYV4q4bzRT43hcotE887ls
         nAKjUEEEH/lUxdwN6ysim2SX17Mu0EBkR1MwXNpz4gWXnkVca4V41mtYYs/t3VwtZJmV
         hl/fT7vGyDxv3NLIMIckD3BXb63r9t0Cm4he8McbyGes5iDc2TAwoEYYsMPL8n0lfkvn
         vFzq6c12JIwSY7vvCrNle+kbeugP2CSV4MUOyzyNHTsHQ2Wvju8E1xiHoSN+LgEGXDZM
         kjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2SmIeY3RvR+sxAopTjlz48utuRp0cXC6WogM9AzM3+w=;
        b=VtjFz80eHH8wyNfmG1Hb6CctIKTjEscAryLeAVrljdtk355SubMrO5ZbknCspdR3TM
         3m5AHCv4+9UZ4LsqW952RzHQIicV/8WEoOdOCUAr4pZatwHtOgngIzG/wzD6lvlK2dky
         7RNQTLanScWEC5M1dCI8snSSQW33/ZmcWrUEk6bWvMOB4z+CX0dqK94xNb36PTa2Xlo7
         5qvNRg5WkzqqEvhuBJBEMa4kFLXhi3+ZPYRmlLIDPlsn8EoFtdj7C2DmzmEizDZy9ZRu
         cOptIHyv+A781CUGI0naWi7blXs/xFyz5MZ32/ZWLTf8dJpBckjuqsX9IsoMWp849IQT
         D0Gg==
X-Gm-Message-State: AOAM533w1h7M7H8gQfsLYxpjuYhquP3qc580px0hw8Vi/MNya/pF5tWi
        acLuSKD5OSWI1qY8B6hqf/KDMrZEbowNzopP05SRYQ==
X-Google-Smtp-Source: ABdhPJyTTVUNOFh0n7PTuZupjbgEZGP7eVl+eNzFcqCcRU0Ygs5MfN4sxLUcyaVQNsM7nVXVXgKtwfpd2fwma75r664=
X-Received: by 2002:a05:6512:3e03:: with SMTP id i3mr5268396lfv.273.1633780977440;
 Sat, 09 Oct 2021 05:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211009025858.3326725-1-osk@google.com> <20211009025858.3326725-2-osk@google.com>
In-Reply-To: <20211009025858.3326725-2-osk@google.com>
From:   Oskar Senft <osk@google.com>
Date:   Sat, 9 Oct 2021 08:02:41 -0400
Message-ID: <CABoTLcR6GM9ynHfyzBF75hVVa_OWja6ibK_37Lx08Lz=Mr9i7A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] hwmon: (nct7802) Make temperature sensors configurable.
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from "PATCH v2 2/2" to "PATCH v4 2/2" (v3 was sent with a typo
by accident):
- Added "RTD_MODE_*" #defines for readability.
- Improved readability in "nct7802_temp_is_visible" and fixed error
due to missing parentheses
- Refactored "nct7802_configure_temperature_sensors_from_device_tree"
into "nct7802_get_input_config" and "nct7802_configure_inputs" for
readability
- Restructured "nct7802_get_input_config" for v4 dt-bindings.

Thanks
Oskar.
