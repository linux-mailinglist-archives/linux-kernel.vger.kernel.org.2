Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92801365959
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhDTM5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 08:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhDTM5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:57:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F4C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 05:56:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d27so4463188lfv.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XPMepYIfCdHU7wP4/eNHGm+W5avu0eYuBbOITBTjPeM=;
        b=CRIe8YE7uHnZHPvTjONlKjfx1NsBiENiobwMK33tUP5kWnG0eBD8O8bZlGegFmcQIX
         miz3TiF+CzJbdoZGjWrMfvaNFGI5S4DBgIPFR9hSNSJa3eiMc1767SbXEFw3kTylDnw7
         oZ6piyM25a8Oj2S/LfmmQVxInQFEcv+UX2wCXSuDSPL6SmM/Ts6ouF8OmJKc0N7Bl9A5
         UsABkMW+kQRdtFIM4I1Dr/9R/WBlqqyPfxaCXSTYYucIaPbJUrUoH1gIMlJlINRZY/NJ
         nLWwuBhGwaBl5cOEioDgTfOfIJvqR5854R/kRJIS2jHVqWTqOZoARyC0fRHLOT2GPUh9
         NqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XPMepYIfCdHU7wP4/eNHGm+W5avu0eYuBbOITBTjPeM=;
        b=Z15dN+g9n7c9+WtHBtiO0M2Gxclze4PEznnKSrvAz/VoUf1pmoav4cddgq6a5+7c/l
         xOOtQCegrqI1jGNQvNXn07qOHskQPRVJS1zivQHr79+sivNuW+TKLQ0bXNFL7lNStrmS
         CvC6TU06aoTUPyDTTPfZgn02VMQkEmuUvYYji56H1QMQtKz4bUG3W2ZEXcjfRf+20eT6
         tR3Y0khypQMLj975mbr8OKIY3qjKTFKxLezLgQX088Qj4a2S7z1tT1AMKavVI8Ar+5ME
         bkK2cQ6MjPOLOdI7Vqs9hkK2rGVLyQZq+qpfx2Inst0/4gOdijBl6A8fCCgcY8LSaH4C
         boyA==
X-Gm-Message-State: AOAM532R14IJWxyZ2lC0Va+oN1SQcqWsMqGfQC+FRDwvJGCPjPA+Jvdc
        bCq4FQfx5fwDusJUbnAtOyVEf2KtLTP3NMnBnjI8wnK7sTJShQ==
X-Google-Smtp-Source: ABdhPJxt0GHfRur9fbeKyd3gCEzrVm/dOo3A+FixtIJnnzYF/W/MLUojDXqmTMZsnz0UuGrc8+RUHfcsg58OBwGLHVE=
X-Received: by 2002:ac2:4a91:: with SMTP id l17mr15614171lfp.397.1618923407122;
 Tue, 20 Apr 2021 05:56:47 -0700 (PDT)
MIME-Version: 1.0
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Tue, 20 Apr 2021 18:26:35 +0530
Message-ID: <CABPxzYKjxW+P_cMLmZgtQN7nbCB3zzksYQWpChC70tbVb6VJCA@mail.gmail.com>
Subject: Module versioning + Missing CRC in symvers + export tracepoints
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing an issue of no CRC being generated in the Module.symvers for a
driver module even when CONFIG_MODVERSIONS Is enabled, this causes
modpost warnings about missing versioning.

The module in questions only exports tracepoint related symbols (as
struct tracepoint is
part of the module CRC), I have seen this with other modules also e.g.
iwlwifi with CONFIG_MODVERSIONS.

Though I am trying on 5.12.-rc2, also, seeing this issue with older kernels with
CONFIG_MODVERSIONS enabled e.g. 4.15.0, Below are a couple of snippets
to demonstrate the issue.

modpost warnings
===============

WARNING: modpost: EXPORT symbol "__tracepoint_iwlwifi_dev_ucode_event"
[drivers/net/wireless/intel/iwlwifi//iwlwifi.ko] version generation
failed, symbol will not be versioned.
WARNING: modpost: EXPORT symbol "iwl_remove_notification"
[drivers/net/wireless/intel/iwlwifi//iwlwifi.ko] version generation
failed, symbol will not be versioned.


Module.symvers (after modpost)
==============
0x00000000      iwl_remove_notification
drivers/net/wireless/intel/iwlwifi//iwlwifi     EXPORT_SYMBOL_GPL
0x00000000      __tracepoint_iwlwifi_dev_ucode_event
drivers/net/wireless/intel/iwlwifi//iwlwifi     EXPORT_SYMBOL

Any ideas?
