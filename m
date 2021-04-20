Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8999365A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhDTNdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbhDTNdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:33:12 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2C7C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:32:40 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i12so7735110qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=g3YcIppg7/ilVSy7kcLKtRaXPe1UXLqqSTnQUs0dEsU=;
        b=xW0uQ31JyQkmfx87N5TFQ85v8GxdnNyqvhaSpXF/WMzSdLtZ/oczOrDrd852nw8mZR
         OJVZU2gky+SEXyUU8KeEsY4q8YGc+4yi8Q2DJ0sFaHcBGwr34VSrgWOrp3r3IJVDFcCk
         PX+zSJ9GCWBeQFFrhTX6VVik2/5fGe7VJou1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=g3YcIppg7/ilVSy7kcLKtRaXPe1UXLqqSTnQUs0dEsU=;
        b=nPDGZHD0gJbYSRTAbh5Rz5pL2GAc3Osk2Xu8NjzFwplYw5qtzwDMf2TmXgWai/B0Na
         vtxo3Y1PaG06kD3FUv3TXnPRbP8X/M0Ycs6lz82Wjf0R9J0+7N/IOYM3bcgOuJcMiysq
         EOtgnPVO9/vfhyXQW9TVspdisMWbnimHPRF10ZHsoIYrUPae/zJYI31CIPBe8fk30Hd8
         d7wn1EcG/XoOLS1GcXhpBUozgoo/cEZ0oio2woh23pkSoyRUaOsrROMofvEcwCopY8IS
         xE7Ncq3LndTVXdsFhhf9kUdFAS6iQiq2BPNpeScpIGZj5Xa0KeNge2ZYMcS5Z84FcLgk
         XHPA==
X-Gm-Message-State: AOAM5338De+1P80Jbm3EgbEZFz9RAeyDnorEKYwivHMXkz0x948FDMQe
        5JJqaiyV4ptGch8fG/+q6jsETg==
X-Google-Smtp-Source: ABdhPJypZYTEyc1UuNGOHEAPKHbjeiG2ILG9vgDNXCcCrljxR5pNGLBa81TIHElN1o2WBYMQXX5R8g==
X-Received: by 2002:a37:be87:: with SMTP id o129mr6087298qkf.284.1618925560022;
        Tue, 20 Apr 2021 06:32:40 -0700 (PDT)
Received: from saya.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id n143sm12601103qke.45.2021.04.20.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:32:39 -0700 (PDT)
Message-ID: <2439425b90fb305cc1938fca22e22505851e9c08.camel@kepstin.ca>
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        yu.c.chen@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de
Cc:     wei.huang2@amd.com
Date:   Tue, 20 Apr 2021 09:32:36 -0400
In-Reply-To: <20210419195812.147710-1-terry.bowman@amd.com>
References: <20210419195812.147710-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-19 at 14:58 -0500, Terry Bowman wrote:
> Turbostat fails to correctly collect and display RAPL summary
> information
> on Family 17h and 19h AMD processors. Running turbostat on these
> processors
> returns immediately. If turbostat is working correctly then RAPL
> summary
> data is displayed until the user provided command completes. If a
> command
> is not provided by the user then turbostat is designed to
> continuously
> display RAPL information until interrupted.
> 
> The issue is due to offset_to_idx() and idx_to_offset() missing
> support for
> AMD MSR addresses/offsets. offset_to_idx()'s switch statement is
> missing
> cases for AMD MSRs and idx_to_offset() does not include a path to
> return
> AMD MSR(s) for any idx.

Ah, when I was looking at Boris's patch, it lead me to one more spot
that was missed with the off_t type - inside the function
update_msr_sum(), the offset is also stored in a variable of type int,
and as a result the background update for AMD's MSR when turbostat is
used with long durations won't work. (It's skipped because of the
offset < 0 check).

-- 
Calvin Walton <calvin.walton@kepstin.ca>

