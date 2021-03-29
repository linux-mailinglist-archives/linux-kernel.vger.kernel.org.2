Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4D34D3D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhC2P1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhC2P0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:26:47 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:26:47 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id i81so13410482oif.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5/8kk4ox/5Tuoi5bHBW9bZqDcQioEYzA8lrAMJq3ltE=;
        b=jguNIistQav6Mg9ilsp9vyb0cFb9GJdQaSiJtGY+DLp9l/oUxDIU8ouOaxiMYjQfAD
         HS0TkHMyoVAnyo4eV6p2W4NR3ASxLmr8N34TzaFPFhrx5G7bPEJw+qrqBiqYvEy8VwbL
         u6MvCKT767Zm/37v0/39NVdOJMLF30ZmMH0RxmqrJmjlKrSX7V9ImxZAqVBcoBtlvTqX
         9fqNSAgDzfVV1giaAy4JaP5pB/STbPJa1wfSg/v/eWT/F1R2ACjTGEDYWJ1gKAUrvL7Z
         LaW6jcG2hTPntWzxeB3xsZfn+EC+QWkDbDlf843CWRb/Xo3Vt7TFaosaC20F5X6pU/n8
         WPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5/8kk4ox/5Tuoi5bHBW9bZqDcQioEYzA8lrAMJq3ltE=;
        b=VLKBPV1uzmx/0/1BB+c4VTsR9GBiID3rKu+WQpIAgpMhHbAmd04tIoggQiMVaTGz0S
         mnnn0CFZNKFD0xlGos5tTHt/zEv47n9Zdl+LhmlK56r9W8AOIZGF5SaSHF7hZ4aSeDHm
         fJRYi0uGsCkobR01Wmluk3HlnwXdX/8wQy/kiGpgzqBm+7lsnyHxcVMvFFPYz/OruFH5
         qHfjOhs1FSoPw+tuKf96RlRa/wBLX21+MPZYBDxCTsmIC9zns/TfTSheRur7npzSlLyc
         xsR5A0LbCBFVbq3P5Mofo8qHh7XkCqvM+bOQzzYpqy6LYYvCC2xzMr6yGo+Iz5sOsUkt
         RpiA==
X-Gm-Message-State: AOAM532Vl7qnMTVbYfqViDWfwEzJshgoFRMiJ9K+HKCp1Ir8HuYCfseL
        BOuSWtFgbCQgOa2oDEdQ3em2cBm/rDgkwMoFHOU=
X-Google-Smtp-Source: ABdhPJzD2wK6mvmhPcDE1JJyROxFofLiiNLfhpW+JO/7PK2DL1T8J2hIAvjpluuAu/53K7DYc6sNekiFTmhfbMUXNW4=
X-Received: by 2002:a05:6808:a10:: with SMTP id n16mr18363144oij.91.1617031606704;
 Mon, 29 Mar 2021 08:26:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aca:be45:0:0:0:0:0 with HTTP; Mon, 29 Mar 2021 08:26:46
 -0700 (PDT)
Reply-To: sgtmanthey1@gmail.com
From:   kayla manthey <hajiaali49@gmail.com>
Date:   Mon, 29 Mar 2021 15:26:46 +0000
Message-ID: <CANpOLzHi5jUEV4RoQ5w6R+AokemcdS8CtajjgparpPxA-aUx4A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vennligst jeg vil vite om du har mine tidligere meldinger.
