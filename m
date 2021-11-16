Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DDB452A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbhKPFww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbhKPFwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:52:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042BFC0613B9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 20:47:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u11so16374239plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 20:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=RPYYrG9UgP07ewltJgDfI6eFWNVAnXyZpCuC9KV3gakD29OW3LxvuCcEj6pQsbZCZ9
         seWBq2QMSlzonH06AM6OvqxRRrvM4nnDaV1IQ36f3j0VRvMoE+oHThdoEy5RXsAbGY4J
         PBAMvbwRAREA3v/zKP1B38JDky3WazXqnI5vLDtKEXkRpe7vx+zLyOhLaBvF7cS4Lf8s
         UvWew/5mJEA4/C5vt5DUXx9CGYsAmKxSyxEo7EZaaXyXRMJuC16GsTqT9xhUab99wWxl
         mtcM6q5Gz1sZ05vdQtdy7Ff2qJLEQd+nzlyfYdxClC5kc2QOq/x3DUy/ydDd6JdutHjj
         G6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=el6NRWApCfool1whk4glMfzjj6s36qvEgzKmWatVgkAzOFLWVCPsgWz16lrJ3ShA7U
         UXeWo1eq2dOXebdJr0vossJuAkaBWC9k9NCOMPVSbYSG4l22kJNZOYnkR8ulDp0pSxiR
         VmAdRnkdc8yeq9pakYVoEf+TdzCTMWiZIyusIuTW84XzKpp7R/WB5VRf27fnwFc6iELr
         QAI7sxry/YYblyWhkQkdLgBzUJpT+E3i+KsdvZvW+sfGcAio3AjNjnoTKFKm1GBe8yQj
         nATSSVmlXLKQM06tlRevoijJ1/vJXkXRaeUDJrp234y43toerbEA+KWbgBjO9xUvZoOU
         D6wg==
X-Gm-Message-State: AOAM532F7yWjxBzUgbcFfmSleoQYvzUwa9wOCBpUban6TcYd2BPXs93p
        XicjOc5GWxpxuIhJfC9BDozTjA/4xw==
X-Google-Smtp-Source: ABdhPJxkxe8j98EOyjg7sUbn16K7t3+dMUctG0wNPkcajiHto9wZJl4PqAV/vf8HHbQHvNR9txm65g==
X-Received: by 2002:a17:902:6941:b0:142:5b55:28a6 with SMTP id k1-20020a170902694100b001425b5528a6mr41867038plt.31.1637038053281;
        Mon, 15 Nov 2021 20:47:33 -0800 (PST)
Received: from smtpclient.apple ([2001:2d8:e203:8f26:a14c:51d7:7b89:7474])
        by smtp.gmail.com with ESMTPSA id d21sm1941249pfu.52.2021.11.15.20.47.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 20:47:33 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Hoi <boongkim@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 16 Nov 2021 13:47:30 +0900
Subject: test mail
Message-Id: <DC5BC4D7-E29B-4E3B-8089-84192E990912@gmail.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (19B74)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


