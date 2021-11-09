Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7645E44A6CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 07:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbhKIG1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 01:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhKIG1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:27:43 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E341CC061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 22:24:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c8so55567349ede.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 22:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=9gIgSLoUOfrsGi0z93sMCBD8sKlaEg8U9x6+1IzpKaA=;
        b=NBbDYUtvTRIImHRB9uJGf6o7+y6fmrswcjQX2INNB02atGvfpvyMbhB3OxmKsf8L/X
         S+Bfy2DpHsBID4PluG3VDQdFMWKX/5GurWOiALuelNwsHUOspsg1rYHqEGcKZIL7BSY5
         thv9APp0kiI+bAdMZlLtBXOhoPFjaRr+uwfs5yjqj/IUJLSI3wkDht8w+SzltDHQqnnJ
         NTH9GPf2LtsGBD5GnJqdHyDZQq0jWflkgdMdoUZdSQmhDvh5EysTUnC9XDNEZUS6tY8t
         7LIgC0rkMiXI9/gxOxQSqqDXiyBBxMSe2RLn2iia6QF2j0/i2Ww5FmpHzKIRSZkfcAAP
         I7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9gIgSLoUOfrsGi0z93sMCBD8sKlaEg8U9x6+1IzpKaA=;
        b=gQliWkEeBLlhNJhey9TPV8sTJlIYPILMrL8jIWKLJOSgucKPPfoGMAK3gJGBYdDMAP
         mlxTOIZwFOu4z1n0UanwuoE0QFCzom0T6Uo9FGCGGAe6OFNHFoZihmxn/abOnNw5j3SH
         y2wNLZtbNt1ujyPUymGfoNPgAUE1TgZGZGN9B/j7FHy3mYVvxxJpLe4yrHN4uL/Kb5Mq
         Z2NgE9/Ftpmhs5Ag0oD0H/pvb6X5iCPhvb8Z7KgEhX8hFYZIxbtBEQC/uT/uR8Vj+mat
         sjZenI+c1pkh+g57aNKAwJduFOU3lN1veJecIC3wmK6Ss8Ix3gQj52EmBbQT+HUfWYwz
         W1pw==
X-Gm-Message-State: AOAM531ciku61P8jZdsxnm2y8bqrJNBaYEOF9RWvRnFB1abay7WDeO9f
        7BlLh3VyXAGs6YLYrOwVDt/ZqI2wb1uNg+wAsa7TgIqH4g==
X-Google-Smtp-Source: ABdhPJwXR9begWhIRGwpy4fYvbWkB1eUMpeIvSxploVk6oGbGb7EdfhAx7Wm4mxQLJFoADWpYT7kuZ8bBLfrBrrHXn0=
X-Received: by 2002:aa7:cf91:: with SMTP id z17mr7012174edx.193.1636439096354;
 Mon, 08 Nov 2021 22:24:56 -0800 (PST)
MIME-Version: 1.0
From:   Joey Jiao <joey.jiaojg@gmail.com>
Date:   Tue, 9 Nov 2021 14:24:45 +0800
Message-ID: <CAKOmCvreB9YbziX8HHx_4K27CO2=9v=eWcNV68Qk-A1HQ+TQOg@mail.gmail.com>
Subject: How to load kernel modules into fixed addresses?
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The userspace uses modprobe to load multiple kernel modules in the way like
```
for i in $(cat module.list); do
modprobe $i &
done
```

And everytime, I reboot the device (verified on arm64 devices), `cat
/proc/modules` shows different loading addresses even if kaslr
disabled. Also tried to remove the & from the modprobe command.

So the question is for testing purposes, any steps to follow to make
sure each module.ko is loaded into a fixed address (especially any
kernel space code or config change)?

Thanks

-- 
-Joey Jiao
