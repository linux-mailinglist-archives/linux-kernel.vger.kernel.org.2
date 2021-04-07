Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D644C356911
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350749AbhDGKIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350755AbhDGKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617790083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nBCxJ0o3bINWUeTY8uTJzzPW9J0E58tiHX6VMm19G10=;
        b=OTJoLFDY4jbbIGhej5FoI1yfZlyKVGVzkXMh52fn0tRnq8AD1TO3vinICJIz+p/8bvPjiT
        09X+mqiDEco6NArHGa0xNuQ3/DGxbcOrgKRv1LEXbdtm+EaV1AUR5BaSPmsa2CmSQXNM1l
        PEZeSpqHJztvzz8nxJXSVoKkihnWLos=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-3vxaYCq1NYy-Bnpjl_q3jg-1; Wed, 07 Apr 2021 06:08:01 -0400
X-MC-Unique: 3vxaYCq1NYy-Bnpjl_q3jg-1
Received: by mail-ej1-f71.google.com with SMTP id jt26so884935ejc.18
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 03:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nBCxJ0o3bINWUeTY8uTJzzPW9J0E58tiHX6VMm19G10=;
        b=XxLqTe76VwTIGJt+B5Zb0UWrh1eBlPu/s/F7vK8E2fD9+cHQawbYN3j/tK3u7nTx9M
         UrclfDN0rpy2MXJ4dKGnBPQIEgxtEDfrw8dNHZFeGYhAo4lFCbw0bhW2L04hphYVEDEZ
         56dasc7wDo1f5rjjmZBqtdHpbyegV3PKhoFmh/JOXP5bfiauqzOpgB0VTFtU4Yum5pED
         dOx+OvdUFxD5uoMVMWgvQcypMLOOkvuZ5nscXo0mNYVaKnbV0NShnuTeA58nYextiadT
         f9yiIk6IvseJzCZAOco79LaWRinTGgHzaxtvGk4sRryIM+Sb0BzheCR15aZxWVLpiHEn
         lqTA==
X-Gm-Message-State: AOAM532VMjqKcDSL79trlMT9HcThb8bzPuYLdoD58pz2ON+Q62hkwrCq
        iqnt1DgHrs5AgGlL2/0QZaaHul4+ARaGEX42m7sE2qFiRLWfNK3I/VmwpT3lQhUTVV/0fEUzPxc
        zfcf4GVHFQ5mMZ8uMYkOmFEOW
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr3358473edd.288.1617790080346;
        Wed, 07 Apr 2021 03:08:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz37LDfDUorLC4jq3U3yk6+qlw0n7GzMMUh2QtX9o1jduRD0upLoLdKWceKNNibQzX52x8Ksg==
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr3358454edd.288.1617790080173;
        Wed, 07 Apr 2021 03:08:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bq18sm8334584ejb.27.2021.04.07.03.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 03:07:59 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.12-3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Message-ID: <5dd4526e-b5c2-4071-0f82-6ecbffe085a5@redhat.com>
Date:   Wed, 7 Apr 2021 12:07:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a single bugfix (on top of platform-drivers-x86-v5.12-2) to fix
spurious wakeups from suspend caused by recent intel-hid driver changes.

Regards,

Hans


The following changes since commit d1635448f1105e549b4041aab930dbc6945fc635:

  platform/x86: intel_pmc_core: Ignore GBE LTR on Tiger Lake platforms (2021-03-23 21:50:14 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.12-3

for you to fetch changes up to a3790a8a94fc0234c5d38013b48e74ef221ec84c:

  platform/x86: intel-hid: Fix spurious wakeups caused by tablet-mode events during suspend (2021-04-06 22:10:21 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.12-3

A single bugfix (on top of platform-drivers-x86-v5.12-2) to fix spurious
wakeups from suspend caused by recent intel-hid driver changes.

The following is an automated git shortlog grouped by driver:

intel-hid:
 -  Fix spurious wakeups caused by tablet-mode events during suspend

----------------------------------------------------------------
Hans de Goede (1):
      platform/x86: intel-hid: Fix spurious wakeups caused by tablet-mode events during suspend

 drivers/platform/x86/intel-hid.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

