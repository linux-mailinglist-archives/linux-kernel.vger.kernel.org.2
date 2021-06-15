Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9720D3A753A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFODev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhFODet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:34:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89524C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:32:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x24so18919873lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=pflB2J1qXM0hkfMuw0yMT8Rp0cX4k3qmhHo1yXlD4iJmIp6ZvDAo0hGldAMKxDftx6
         RofbeiduvnPuDfVvJv0ZhfmDbJxOw63UomtNC3ZST17xDDrm3rKqiyB0cLCjdClzT0/j
         3/+TQQCjq1W8rotVQ2RuJpXU8U+Kc1ujQYq7HAhayf/pmCoPAfSRZyFNeenFpuootkh2
         YZkYewmXgsUUCE0LR/rnUf+22Gs7iGQlZ1O/odfNO4OpmoH0XgyeDUIxraakGQ3pGBWF
         6HkMKbMg0XKBXTU5Nv8oZsMZdzighyQ9hlzCih8Vg3MaeyXZ2oD3SXFhcbi7g/op5hIU
         GdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=Ue02DNgPNoiiDUVCVzXXT0yG4aqzhZvHRfGkPEGhDlRCFYOjzz85hDRIJ+DQzMgHJL
         f4K7cyTPQskN+13EMuKIuc3uQH/naUTAUA5QZLe/8yhwDg6aiqSXTGmgrHCWcbVI7RFn
         dnBpzgKmbvqFZWbf7qrrz8/ybhE9zUo4bZOU8ZGcG9WzoIIUk3Ny5x5wZW7qMrdpzALR
         emBk7JRvR1DlIX/8cv+qcJFLHX0txT/pmMNxRGR0PYeioFSOAqXM87ywpHytVBLFERca
         368nnB7YlFEZTXU9NN41PbZ0KuwpzU0ywvTiyJzfXRVx73B8l1K1BalWCpKS5ZREgG86
         xe+w==
X-Gm-Message-State: AOAM530tMocpi/13wF5SmhlJXZY85hVTHeMeXiHmxkJ5xjOg6/upMZ4k
        wYQXY6W+lq+LKD4CSzO85WLULwPNswv6wE2N0yuQjPiIm9Vmxg==
X-Google-Smtp-Source: ABdhPJylVBcZ6rd3AUTSOcNx+OJt5vvjUGWaOSmSYoRLOZwQEgNSPkXhDpAyBFaS+5bfZZA9YkILKjzmaJHr1D1Huyg=
X-Received: by 2002:a19:4f1a:: with SMTP id d26mr14425707lfb.265.1623727962836;
 Mon, 14 Jun 2021 20:32:42 -0700 (PDT)
MIME-Version: 1.0
From:   "R.F. Burns" <burnsrf@gmail.com>
Date:   Mon, 14 Jun 2021 23:32:32 -0400
Message-ID: <CABG1boMsJ+8OaLPmFcNZPRVPRRxd9gasxjZNwUy_3FD07XXO8A@mail.gmail.com>
Subject: PC speaker
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to write a kernel module which, when loaded, will blow
the PC speaker?
