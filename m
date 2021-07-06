Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE093BD55B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhGFMT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243273AbhGFMDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:03:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712E1C07751C;
        Tue,  6 Jul 2021 04:41:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so2031324wmq.3;
        Tue, 06 Jul 2021 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yv7klRcSZNtoO+YCPzzJU5HrTFcadvUP9OGq8uM3AYc=;
        b=kh0gENRgiF7456HhDfb2cjtr/8R3mpJgxXweExUckOVsD+AChfL6aXSpTG1e2l3BlH
         31sZyt39YzrqQIBTn3KqxCnDV29dO0Bfpt9dM7v5lXNdZ3qX1yf/nbgmbxELG1TWsUFD
         s60Vp6OuljQO+OnKk77rOM/c0/8L/RugQtrD0D4abW4e2Ovz15htqDDvRnr2cPXViS+f
         3FcXqXTu+As1ayk8kFMiq+coq4NdR872g/cxFEmPQteIdrXKsezsS+fSTLm2OTjFdAUx
         etifkuwW1w+oaj7vhQkSfUaMMU8i+itGKHLrtoIz/zv4tkLzPSDvmf+rI2iWl9T4sBz8
         V1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yv7klRcSZNtoO+YCPzzJU5HrTFcadvUP9OGq8uM3AYc=;
        b=DlPbsrpJ/pijKOipJuQTFYamhqcSkBG7RUBZbXty0NCkhX3MI/LzthRQgT3lxFBiCH
         uBmAkwekUbranIjhFJnaWVB68AUnfXS0NWcayptNIEoBbAqJ/OvvLUaJG//VcYqNHkAe
         ikrxxbJ3reZIMEf83JkQCUorz6nW0tAB7tIbBNWgKWDeZuGoSYzVSFSvHliicZJnsvfy
         2PTSA3ssaZNdF8ra4pZmv5stOnDcQ8BxM9Sycp3bQ99LnfDaoDe4t9Fh99mQ8HWlpFm8
         YL1svl/uxluXWQJErl0bOXNBgah5FUZhTFSxzpPwAyZBB9tYW61xP/I4Acer91qAaIyi
         VYLg==
X-Gm-Message-State: AOAM532zpeh+VAvVMiis/m7Z68FpiAIVohXg7i66G5EmJWrWpvoNBCyx
        teBMcQZ+0WCbLMEPALzpj4dvUm7uJr6tgg==
X-Google-Smtp-Source: ABdhPJw/ux9cwM3B9ZEoeOKZ+oL1O/ymqYB72v47d6vrhwxWsN+MpraTo66j7QOSyT9xeiWfe5phtw==
X-Received: by 2002:a1c:2604:: with SMTP id m4mr20084439wmm.101.1625571692938;
        Tue, 06 Jul 2021 04:41:32 -0700 (PDT)
Received: from masalkhi.fritz.box (dslb-178-005-073-162.178.005.pools.vodafone-ip.de. [178.5.73.162])
        by smtp.gmail.com with ESMTPSA id h9sm15232849wmb.35.2021.07.06.04.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 04:41:32 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kbuild@lists.01.org, lkp@intel.com,
        kbuild-all@lists.01.org
Subject: Re: [PATCH v2] block: Removed a warning while compiling with a cross compiler for parisc
Date:   Tue,  6 Jul 2021 13:41:16 +0200
Message-Id: <20210706114116.98267-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
In-Reply-To: <202107060648.767XjMRK-lkp@intel.com>
References: <202107060648.767XjMRK-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

Thank you for your comment, I have fixed the issue, added the discussed tags, and sent a new version of the patch.
