Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A3A3DCF04
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 05:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhHBDwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 23:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhHBDwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 23:52:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F115FC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 20:52:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mt6so23497094pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 20:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=A3yKS+S7QoJvrWR3TZgGwfqKMa4csSkUIxpozB45T0I=;
        b=JbdgHXn8BqA6VObKsM1YIVzlM95LSeknR8y3MqPj4mhnyN+yIJgJmAUg/tOHXWFGsG
         GeyGgKrEzdm5UCmLOqLN7PJE6ctcii87TL69HsB4uXnd6JokA4xDCdTKXnMmJXux+ePD
         lzelYyw9pih4uFt7LtyKQYPqovc5yV4y3EQLRiEtwKvZLsPh8M3dUtXgBQ92JHUS2Jho
         embusR3VheIPACQ4QV2YKbSvdq+0fjXqhmj+Wodm0cprofcnsE/xyhwQ1lMB8YdA7pW6
         0GNhsi44ikQq1m1ADGOruqUWlS+IpoXv6wFCEYNV3X9/tFZezPUbV232M7YKgUOwY4dm
         2K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=A3yKS+S7QoJvrWR3TZgGwfqKMa4csSkUIxpozB45T0I=;
        b=iW9zW6oeluFDnCtfO9Z6qG5crREWdSml3EXV+vA1jO81Y/FyNvJzUAVKgzjykoeNi7
         Kz6BqwKyg1HXao0Mywgf7Z82fk2jWwH8OOBiRmNl1QzRAsaaag6AIaFCpPNFIWJ4qiM0
         4JIYmif/IuqvpGjryfqc9mhwZFKC998MPdoM8r35cBUFTBqzgEPiz675NARGN4/bYW8j
         2L/Bu/zxcWDF7dj+av0dqD0uEMYIyHZJyQgbToKHvo06lki4zjMXWfPKBFy+cKUETlxH
         8ohBd7vBfT32WJ00AXvAnSGj2NfAuhIRjDRUvr1GZpG3KAbPHlnHQbvoWBXyyJJoojjI
         v6Rg==
X-Gm-Message-State: AOAM530pM5i72wz95MCDyitJbDO8f0N6rVKa8bcaiDTghS2OWk17huLE
        uOw+ztpjbot+gyit9LiMsc31oA==
X-Google-Smtp-Source: ABdhPJz6z1WTyI2ZQ4BaEg9i9nTjk6BpSo1784NNW9rhjhvUrLzlbfTKxsxM/ypFbaLOnxKY9gpv/Q==
X-Received: by 2002:a17:902:db07:b029:12c:bdf3:73a3 with SMTP id m7-20020a170902db07b029012cbdf373a3mr1126168plx.5.1627876364212;
        Sun, 01 Aug 2021 20:52:44 -0700 (PDT)
Received: from [2620:15c:17:3:f081:306b:20f6:7d15] ([2620:15c:17:3:f081:306b:20f6:7d15])
        by smtp.gmail.com with ESMTPSA id ci23sm8715400pjb.47.2021.08.01.20.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 20:52:43 -0700 (PDT)
Date:   Sun, 1 Aug 2021 20:52:42 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Luigi Rizzo <lrizzo@google.com>
cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, rizzo.unipi@gmail.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] amd/iommu: fix logic bug in
 amd_iommu_report_page_fault()
In-Reply-To: <20210731192637.3653796-1-lrizzo@google.com>
Message-ID: <6d9bf4fc-4956-70fd-6d80-2b0ee92a571@google.com>
References: <20210731192637.3653796-1-lrizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2021, Luigi Rizzo wrote:

> amd_iommu_report_page_fault() has two print paths, depending on whether or
> not it can find a pci device. But the code erroneously enters the second
> path if the rate limiter in the first path triggers:
>   if (dev_data && ratelimit(A)) { A; } else if (ratelimit(B)) { B; }
> The correct code should be
>   if (dev_data) { if (ratelimit(A)) { A;} } else if (ratelimit(B)) { B; }
> 
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

Acked-by: David Rientjes <rientjes@google.com>

This would be very helpful so we don't erroneously classify these KERN_ERR 
messages as dangerous.
