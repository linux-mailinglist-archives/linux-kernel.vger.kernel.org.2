Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7D36EF94
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbhD2Skz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:40:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59817 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbhD2Sky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:40:54 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <tim.gardner@canonical.com>)
        id 1lcBa2-0001uY-I1
        for linux-kernel@vger.kernel.org; Thu, 29 Apr 2021 18:40:06 +0000
Received: by mail-pl1-f199.google.com with SMTP id 70-20020a170902044cb02900ed8431f861so2004119ple.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6ISdJhxPA0Q81HhhbPQowkOtokNi1L68q+uJq16mjrQ=;
        b=S+D9ZE1MQFYDcdZMtmh4n1LNe5XPvtPZG+TtRWyohK1l1CeoW2r1QGPNksJ7lLcZ6I
         o5MkQBrps7ZDJGIU7HvR3d26ugK2q16/0j5eZMuREVYoot+Rm0sQlH7pB+G+P7ATUAKr
         CkjEJQOy0m/L/bTN6NdAIZofyS25qfAodWhW8HpDdLJWNXLPLrkesiWwrSvni4bbZhBP
         2m9pPeLTB3cR6tcedQvnwTr9M8tcqBaaHODC16fKNSc92cZw6AMcWKjUiHcfRfFEq7YF
         I0CbdliWHdAX356DgdKaERvfAP2sR++p62DMP+MQYR7fFcczeDRUNF556ka6xP+N/ws0
         Lhkg==
X-Gm-Message-State: AOAM5326h7nrVPI8/f0MQ2j+vWz+6cY9CXYS+3OO9Qf8JnOMktg0QeZG
        1IOg4XRy+Fxb0dc8dnTswpG6mYNuIqoUyMKA09WfeRlUtFa5nb7lMI7aG3ZOH+g85MJxpfqeu0X
        sN0H4l1dd+S0BO3a/iYxbopa4qNLTW4c0hwMKEIwr4A==
X-Received: by 2002:a17:90a:c7d4:: with SMTP id gf20mr1275742pjb.106.1619721604716;
        Thu, 29 Apr 2021 11:40:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznlTU0FLh/a/y3qttY/aCK6bTZoKBFq19ZesrnJ0eRu0rUGJ1crYWi4jCsj69yn9y3SLiV2w==
X-Received: by 2002:a17:90a:c7d4:: with SMTP id gf20mr1275724pjb.106.1619721604511;
        Thu, 29 Apr 2021 11:40:04 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id i123sm3566618pfc.53.2021.04.29.11.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:40:03 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     dave.hansen@linux.intel.com
Cc:     tim.gardner@canonical.com, jarkko@kernel.org, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Subject: [PATCH 0/1] SGX self test fails
Date:   Thu, 29 Apr 2021 12:39:51 -0600
Message-Id: <20210429183952.22797-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just starting my learning curve on SGX, so I don't know if I've missed
some setup for the SGX device entries. After looking at arch/x86/kernel/cpu/sgx/driver.c
I see that there is no mode value for either sgx_dev_enclave or sgx_dev_provision.

With this patch I can get the SGX self test to complete:

sudo ./test_sgx
Warning: no execute permissions on device file /dev/sgx_enclave
0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03
SUCCESS

Is the warning even necessary ?

Tim


