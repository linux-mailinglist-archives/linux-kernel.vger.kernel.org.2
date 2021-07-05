Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDE13BBC5A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhGELr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhGELr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:47:27 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45485C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 04:44:50 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t24-20020a9d7f980000b029046f4a1a5ec4so18072301otp.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:cc;
        bh=nw8h5h5Z0OKTt3S/8cQGOnDIyxBkkGmujthbt8alB2k=;
        b=CYPHKGTTVbdtjG5gtIN96ZbppZPmSzq2fAhK4jR16i1EXcg/Vd2oAq4LGlBDhMJpbO
         YeDkbGZ/X9eNjYxymsudYOZ0jeYcOiEezb8fljeS4Aa6B5sF1t2F0dS2OV7BqDo3qs2e
         D8F4HPlBwCAyicJemGuCosLDVKmlmSzQI2QT2+Z5ZZO1nyEPk1aH7vtTf3S2eAlgLEy+
         iWa0nOzOz5azd0828NxNZPe6dLf+NQVXbaLq6T54H5ce+MB/zhEeWCi+vpPpTSccO7ID
         0WwPEddCSv1PJm18YvtIUVfYAdmoIaQm2uvFlD8e9AixLCcuikiO6Io8wLrDeZMBPuMc
         oS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:cc;
        bh=nw8h5h5Z0OKTt3S/8cQGOnDIyxBkkGmujthbt8alB2k=;
        b=Z0r4E3MJVzwhbdGA8oxqno4ZgzUEwZR7QHQiFpFhANsgMQq3fvWGSn0MySYBwJsnRM
         DoDtlRQukyiy18mCv2XjQeahwzvWfLKAnbmQwB3ZLHxagiKKXZm3ehoiv9mVwnQeBmw0
         KeKsXWY4E3FWUMJykhWtByDb3xJLjVx3zb+vTI0HNkYMfdjQtL5ynEzbThl7tvh5nwG8
         t5cCnzNj6CIeJYtIlzwOA1rT8glf5bvxqFbAxMFkSvT91Pt+Mw3xziteFXF/vKZb2P9s
         RoSPHldkO92B4YdLk3HwB7FebjpilqQ/mr80jvX7oxjFMOz2ESNSfjjEUGXYaS6Copb3
         8C7A==
X-Gm-Message-State: AOAM530O95mjcXcukRMGS4aFZjAeVdn91vkxYyDm0uQ/YXojpDvfemo/
        RkXieeeHHCpXcNL4O3EKXxYN6W9fGRehZVHRQgo=
X-Received: by 2002:a05:6830:604:: with SMTP id w4mt9345998oti.133.1625485489483;
 Mon, 05 Jul 2021 04:44:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7049:0:0:0:0:0 with HTTP; Mon, 5 Jul 2021 04:44:48 -0700 (PDT)
Reply-To: mp034367@gmail.com
From:   Pepe Edem <kristengriest098@gmail.com>
Date:   Mon, 5 Jul 2021 12:44:48 +0100
Message-ID: <CAA4TxLB747kEf2eudzU7MmdrzOsc55AX7Kg7+bBik4UA9_E7fg@mail.gmail.com>
Subject: good morning
Cc:     mp034367@gmail.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do you receive my message
