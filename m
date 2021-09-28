Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4785D41A9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbhI1H3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbhI1H3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:29:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00717C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:28:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r23so30908453wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FGfM/v2xR28I5XOPKLkVMm2UhlBEzkYjUaF3UDPtFao=;
        b=jzNN+tiA9aXQ+cWR8TfNM5yq+NXWs/PWcKNtNOAMATQ9+9grouwdxfDMKzNn3VqeiG
         9o1vVPKfoo9beBm0t5qGjlFGZtlO7FBNw+lKgwgz8wDgiiEcMaoVI+815PzySGdC7I5I
         TFZRRPQvFGMAEacX96q54/stXmUGO37tvsyc22Fy6sKxc9l6FOKUGtm8a2XVkiKPurzO
         6RD6QR3YvTHGzWMI4eceGAody1HIjZ/VIdZG0mWP5dCFaJJr/3HDOCSxMZw5adaea8gr
         kLcYcz+DfNaAlOs6+VXePplrh0m+QHJSBBZDRSLZH8j3jCpgdrEd/wmMfHJADhbOipyS
         43Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FGfM/v2xR28I5XOPKLkVMm2UhlBEzkYjUaF3UDPtFao=;
        b=NVN7fUIENMmJS6boC+yQFtEc1E2MyHxJyxtYaevdzuK1L4/8YWpHFW5V9CEoiZw6za
         g2RFAHvdb2k+Gvr601gbm5kfYdOi5Sb/ApH0ZxFaytGCDhDlY0n5nH3kSOZ/HP4+cFZE
         yVhZsrotbwdrR229nwygRvraJIT6cHPurMuzLveteTmR7lqnnyJkC8k0ncDFOAyu9a37
         pUAltfS6/vgSM0qTY3/3GC5Qj5G5p4kp/bLNrwQEqnRB/6mqyXgEwHqP/N6czQRsLXEt
         4COnYIYuTlCLl5M7LN/jdUOcml7FHRGZzTrxLHFm45mQSUeYqWkicKSXthrQypTIoeQx
         RZbQ==
X-Gm-Message-State: AOAM533yaYSlcwNZuJtwTGJxFqThaJO08kqdnsuKUg2jX/55nkWdr6JW
        Tjnw1TXmEDAjGxzLaeOvfw8=
X-Google-Smtp-Source: ABdhPJx8rQsbuu6nCfDH1zXomSYp4Pxgm1NSLBXrhacB4fgXtvlrX7rJrBIt14B9MkhpbPqPGV9+Uw==
X-Received: by 2002:a5d:46ca:: with SMTP id g10mr4531600wrs.269.1632814079688;
        Tue, 28 Sep 2021 00:27:59 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id o13sm23646917wri.53.2021.09.28.00.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 00:27:59 -0700 (PDT)
Date:   Tue, 28 Sep 2021 09:27:57 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     linusw@kernel.org, kaloz@openwrt.org, khalasa@piap.pl,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: intel-ixp42x-welltech-epbx100 no longer boot due to 463dbba4d189
 ("ARM: 9104/2: Fix Keystone 2 kernel mapping regression")
Message-ID: <YVLD/UMRYA55WiGI@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am working on puting my ixp4xx board on kernelCI.
But it no longer boot since 4.14.
It only prints "Starting kernelUncompressing Linux... done, booting the kernel." then nothing.

I bisected the break to 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel mapping regression")

With this patch reverted on top of 4.14, 5.15-rc3 and next-20210927, the board boot successfully.

Regards
