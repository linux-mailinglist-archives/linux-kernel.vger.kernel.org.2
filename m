Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6483A252D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhFJHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:19:32 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36429 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:19:31 -0400
Received: by mail-wm1-f51.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so5355636wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3FKf2+gkMWIhlRbcIHR68ePBWDdt54bok6Q03a/gikU=;
        b=MUG9lRTWFssDqV6Jfp/9MhtqN3eDPBZhN4PYQUvQkGYJ8fIRx30Tn+87YBoy1m2wm3
         DTKhwAwVKYoUvxFYSuAS5bRfyPVzBBH9CGIh1Ag2hHdgSCrpgLFWcezZC6Axer/1KWMT
         BVxMPHMTzJlHxt00s3BdQWv5MgjvFjTED5ckdEqVcSOUIlfYv5Bj7rg9eCGd+XObIArh
         HyL2g9wNRMHuXxgOveplHjUFK6jB1i5o91FVp+a0LkjjkQF5S7+Wfy+kqZ52bLYXHkDs
         iq3Ersrh1/iq5uQvRNGnwgUvATgkSNbPu4n4dvLCASNPCPbQa8nATBA77W34A8z4xVfO
         kiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3FKf2+gkMWIhlRbcIHR68ePBWDdt54bok6Q03a/gikU=;
        b=R6OkyBcfsKKcHGprAtqIBC7Ob/GpyUiakmmN9Ke5K8X5DAGB7GJDLqSUsX6mKSXl4a
         Jg6459TTymQbkZ/nC8D5M4ia+aonuGGv8qoNLhdc5qlDb/an7nM0GeY+4Xl/Tp1sUcdb
         RcUtqusNwXVWgjspNLo+j3/DVciF8bzSLyb2jYZb9Rwk7WNi/Sgp3EUQYQvMgQuOmE1f
         GA2BtN2DquL3HHvs8KoCb5a9wARLZjjiGGcyd/og15ECZc6bgqC0ZVhMrvjBiOuCICVr
         1HcZ56ggMuQpQiODu3fKwoHYoMU9kBelXhiEqGoMRez3hBr9+zw0Zoy9hhIS7Xi9LEW0
         3qjw==
X-Gm-Message-State: AOAM533hCtWw14ks+Qf39w0Ma4pEHQZ9VW0f8OPgLAuhBCy4rn4ixUZf
        lCCfzbJELpaQowQYDliog/e+WA==
X-Google-Smtp-Source: ABdhPJzajlyBEFmkfPc4QpDBXyGS2DoZ3n0rGa+jAjMCVHOCmlhZIn3rUP9QN06Z326tVRqf8SersQ==
X-Received: by 2002:a05:600c:1c8e:: with SMTP id k14mr3586505wms.61.1623309395407;
        Thu, 10 Jun 2021 00:16:35 -0700 (PDT)
Received: from trex (138.red-79-146-80.dynamicip.rima-tde.net. [79.146.80.138])
        by smtp.gmail.com with ESMTPSA id v7sm2348769wru.66.2021.06.10.00.16.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jun 2021 00:16:34 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Thu, 10 Jun 2021 09:16:33 +0200
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ima - wait for tpm load
Message-ID: <20210610071633.GA30216@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am enabling IMA on a ZynqMP based platform using an SPI based TPM
from Infineon.

The SPI TPM driver is built-in but since the IMA is initalized from a
late_initcall, IMA never finds the TPM.

Is there a recomended way to work around this issue?

fio@uz3cg-dwg:~$ dmesg | grep tpm
[    3.381181] tpm_tis_spi spi1.1: 2.0 TPM (device-id 0x1B, rev-id 22)
[    3.423608] tpm tpm0: A TPM error (256) occurred attempting the self test
[    3.430406] tpm tpm0: starting up the TPM manually

fio@uz3cg-dwg:~$ dmesg | grep ima
[    3.525741] ima: No TPM chip found, activating TPM-bypass!
[    3.531233] ima: Allocated hash algorithm: sha1

TIA

jorge
