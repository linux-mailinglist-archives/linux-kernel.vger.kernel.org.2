Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC240CEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhIOV3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhIOV3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:29:31 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B897FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:28:11 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n24so5319605ion.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDA4AbD60SFQgHVVfmZC7gzxpvrFiSmOOYbTULWaLEg=;
        b=Qjzr/Msnp4BvPg/qNnrI0V1bBRyfDQKd5QFJi4DBTQ5AhuP2EdO4J2mlMt6YLgC0QI
         MRPmRnmVkIodrj9Qy5xs0GHL/Lcfs38Gjqdn+Bhq1Yy3qXebQxzmtSB1YHgovlkTfjJK
         sr93BTNkDWmEB76iRgnmV4JYn31QbCTDCi7nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDA4AbD60SFQgHVVfmZC7gzxpvrFiSmOOYbTULWaLEg=;
        b=BEV4ty5UTWCY2bPMwpAFy2w466jijoAj3yCcMFew4yKBDoab2J7Ev6Vu0qXU/32LEM
         c9czKJDfzEeACo3Gs+aY7932N744N2g85aTpLjqoeLBaVIRdqynG2z6GJBHASDijmuuB
         JdEXbsXTAFPaNmsBvRpKm4iHodI8LEn/nE9uwWV9CZHZ7jn0rhCH/fBpsucC2ojrVAB9
         58TMRehs8ay3lmM+CjVAJ7SWp+1FAEJ14RrjwdE+wGiDF+quryBFwsOl8NP3hqOfWQSc
         H+m/3CUP55u1jWc4U8lX9EsgcLu23QEi04uQxTZdeY2GJ0UoTi08bw8d2WrKdbv5ArVO
         ZvAQ==
X-Gm-Message-State: AOAM530PrsSWDLkeBOKzD5SwpUL8FCwc908jGo5+ZOneGmhUhNfrRKe0
        Nr9MtIuDa0igabfbnf3lVla7+Q==
X-Google-Smtp-Source: ABdhPJw7MApHWV4jaw0J0zFKmXPFTdcnTqBXPZ1RmVMFUrAhVKKMFiD7J9ZQNHlpVEP9I8Sc5YDgMA==
X-Received: by 2002:a05:6638:1606:: with SMTP id x6mr1766871jas.25.1631741291173;
        Wed, 15 Sep 2021 14:28:11 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f2sm622884ioz.14.2021.09.15.14.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:28:10 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] selftests: kvm: fscanf warn fixes and cleanups 
Date:   Wed, 15 Sep 2021 15:28:05 -0600
Message-Id: <cover.1631737524.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes fscanf() ignoring return value warnings.
Consolidates get_run_delay() duplicate defines moving it to
common library.

Shuah Khan (4):
  selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
  selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return
    warn
  selftests: kvm: move get_run_delay() into lib/test_util
  selftests: kvm: fix get_run_delay() ignoring fscanf() return warn

 .../testing/selftests/kvm/include/test_util.h |  3 +++
 tools/testing/selftests/kvm/lib/test_util.c   | 22 ++++++++++++++++++-
 tools/testing/selftests/kvm/steal_time.c      | 16 --------------
 .../selftests/kvm/x86_64/mmio_warning_test.c  |  3 ++-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    | 15 -------------
 5 files changed, 26 insertions(+), 33 deletions(-)

-- 
2.30.2

