Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD993C17B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhGHRI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhGHRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:08:56 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F3C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 10:06:14 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z18so2020164qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8N8qHtLLykR6yEKNYZWMQ2G7Fnw5C6fB/kyjlI6reQ=;
        b=g8O5KBosOSucEeZRk+5bfslPUPuH9TPetdeYFFtsWvl/weZRxk/Qq8qQxMMIkhEg/Y
         E6FZnNcaUD3yO3eMl3IfcmbpgmLYKiscL9NhqrTebQM1+UPapiHWIh/WO6L7o8VxfzzB
         v5pmqqeU+GlKk/ttDH3+IeApcLCS7bqGgX5c4kXpVYw6wS7RpORxWNVsdUX+QiZYsUc6
         1q5kqP9WGjgFRFTFEQV1ryM7dkPIIDgz2YDpmD3CUuIgC8KKKxS1PFmQLpkG44Pprw0Y
         e2byThou2uKp3UKZE7fNfUqNtddzaTDc76ZDacL11jjdm9Mh7zV+ZvxxwNyCBH5oHYbF
         YyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=v8N8qHtLLykR6yEKNYZWMQ2G7Fnw5C6fB/kyjlI6reQ=;
        b=ERVyI8nMNVHfO2EW1zHHpREK6v3FV3Pon4JRzmD1ulNGefqaEWD1h19eb2Ld8mUxn5
         2VZkGPP9CuSLp83xoMf5TR2tJHK0BK1LgLBHSphgFaDTwjJHWALHnD1fy4PR3jZBzQFS
         Ypt0kJb1Rc1nOULpi7TtJsQIX8/icTo9tqhRHUKE16VoKhoJYCKkKwA3FkUfh5ZhBebn
         TNcNA4U5Aizx6KRU9prDFgZxRX9SIC2Xj+5xG213UPr3lueoJBH0FX1iA42c32eBvmjJ
         t2mYWfakBiaxiFKGnDduN7TdbCNI9E1L2loNoHHBsp8fS5whhvrWE2SOevcQhuxpqNwg
         cC7w==
X-Gm-Message-State: AOAM533Qxrj7E/mIs6ECG7PqVjgW+Lb2i8sBQaOWS0HbrES4pA6wLrwm
        YdtolSWgaR3uj8caZycx8rI63g==
X-Google-Smtp-Source: ABdhPJzHQZ8B1lr5p25S3m9SIxDH2IP9FeeTkOjgo/KLrfroVDQh2RP2R2mJQSylS8W8T9A3Q4jUXg==
X-Received: by 2002:ac8:4e13:: with SMTP id c19mr8143151qtw.368.1625763973560;
        Thu, 08 Jul 2021 10:06:13 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id b7sm1202878qti.21.2021.07.08.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 10:06:13 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: atm: Follow the indentation coding standard on printks
Date:   Thu, 08 Jul 2021 13:06:12 -0400
Message-ID: <4121270.ejJDZkT8p0@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <YOceNJYQJiPh3qhc@lunn.ch>
References: <2784471.e9J7NaK4W3@iron-maiden> <5630870.MhkbZ0Pkbq@iron-maiden> <YOceNJYQJiPh3qhc@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> 
> So maybe it is time to remove this #if 0 code?
> 

I agree Andrew. It is indeed very old code. I will just remove this #if 0 and 
send a new version of this patch.

thanks,
Carlos.




