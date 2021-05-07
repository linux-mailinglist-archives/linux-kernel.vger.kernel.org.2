Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C215A375E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 03:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhEGBT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhEGBTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 21:19:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B2BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 18:18:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso6226153wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 18:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=DSwvGKS1jNM1D6gponaq7qYjw50BFntiNIfISExlmuI=;
        b=ULzNzegyQJBKhEaqoLRbMzgZwfl76IlvvGtAUf2AGWqccyOMmLLRYWIhdmTjvqsdcq
         tBtoRRAJ3Zs1u+8MUICEp5/hhwTq5dVx5VQ0bFBoGPXCnyuVGEaS/YB2cMUj0AZKc1z1
         8TAhM7wBPYjQjUh9aYB8S0S7vLYLpLEY9GT5uqFCTKCm4J7GNVQiM7iqOTWUMm3oNxzo
         zxeL+xqKptoBr0FVQE+poNuFR0+ICMeepYgWb918b7YAt4X+G9rurvQE1XJMXd/DT8gL
         PqjcYT8SXS7AveoVx900pAjUhjLtxIjaV2v57AEqAYgBSoNeiaT/5iZaROyvoTPzbsCy
         +WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=DSwvGKS1jNM1D6gponaq7qYjw50BFntiNIfISExlmuI=;
        b=LskxOAWBC5wIdYqmfsM/olgmv5BiAPejUWUS3UwjJ+YDHi++AVNcXuP5GJakf+jXwp
         +0nN+0EMuhT6BinWf9SsdhzW+Xl0JkZyc+8jPf+S24UpLbkBcHJgsrP9+/+zc8gB+VVF
         8FDkPHXrgmiEaLvNzLwztLl9g4Vul1pOVpLxkhs33yujYx2CK3KdsgnLNdNLmSbpeeRn
         EBOm8Lj4KbO8wnD60Tr4XTQEHnzO3Pktw+qiXFGbpNZywjPMxKISvrKhK+jm/+Tt8Zr9
         o6Qg/ouwUZ0zwMNrag6XHClCwWMH1t7wV9wU6lhSWrY08LU8UBKUlAm+yro5RdbhZnHb
         Tsrw==
X-Gm-Message-State: AOAM533PMnCjb4EQ2LbByLgeUbkfaWU5St32WPcat5jocRInLDfAPyVy
        B54+ZAcVyHKdtneCBCWbI7Y=
X-Google-Smtp-Source: ABdhPJzzFH4P4bm00s3U4b09n9+UvJj3NmMCnnbpNhKvEvOPWo4V5n2ComUC5DjHsFBV0UgmFusWBQ==
X-Received: by 2002:a1c:1d17:: with SMTP id d23mr7037485wmd.110.1620350334713;
        Thu, 06 May 2021 18:18:54 -0700 (PDT)
Received: from [192.168.43.150] ([41.219.50.176])
        by smtp.gmail.com with ESMTPSA id l14sm7073880wrv.94.2021.05.06.18.18.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 06 May 2021 18:18:54 -0700 (PDT)
Message-ID: <6094957e.1c69fb81.3ee13.4508@mx.google.com>
From:   Camara calatta <awibrahima34@gmail.com>
X-Google-Original-From: Camara calatta
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: HI DEAR
To:     Recipients <Camara@vger.kernel.org>
Date:   Fri, 07 May 2021 01:18:47 +0000
Reply-To: calanthacamara15@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WANT 2 SPEAK 2 U.
