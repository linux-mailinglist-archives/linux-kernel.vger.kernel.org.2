Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831323FC46C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbhHaIl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbhHaIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:41:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA07C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 01:40:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n5so26309587wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=tpgdwJ8aV/oJ/3Y288K3Jw8J276wPQjTvmO8SwKNYG0=;
        b=bjo1Law/Ha4kZL71sTf78aIyaLtyP4Wpd6cl3zusSDioAxkSeyi8SPBxU48tgylgwW
         MaZEjHcZ+h1Bt0vsWsCMNBReFQEgSWeQYJEjyfTEBPEs8rnxB9fUUIOel8n6J+Qr/BSl
         orfWqHLIYfecr/09JrE8xUDH2vndw3oRyDDrQ68o6tV5pzt3+8U62HwRA/eHhLEVwVEY
         sfOFhuzc1DpWXUSbbR7I5/ogiFLJsA5twJFB7zhpWqyN/dD2k1FXcgUBUfOUKOIg0bwx
         iXioON0NpfUjbPd3LziVExTPGK/Ly/SlUiq+3YKJBGO8DpMu+E6DXKbKIEj63y3XErAc
         +l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=tpgdwJ8aV/oJ/3Y288K3Jw8J276wPQjTvmO8SwKNYG0=;
        b=FctMgFtqjt4LYUW/KNar4p8sr/QuBxL0OyPyuuqJGHrfvTUaesh06oEIg2dcXKL/qr
         atlraAeI8EM8/P4+LhIVm0zS1I0idnMPG4YUtPeunAnHTlQrcbqnplhiSSDPB/5GrzqJ
         oSKPiobXB5tQ7jbRBwN+ZmmEmf6IQl0wNjhVaCcJ4sXKoJZBTpLzQScRIpjhbgx3M0VB
         9MXpLd4F2xAxow4nJDog+3Z4aWYdAxHPV7c69pEicY/dAdBXGUN8akeyIf6i1hUdcBap
         rRNje4JY9ppaam+3AYr95Nx5Uah6QFmLlzo6dV8rbVYKtHsnkA+LYhDxGk7IQyHRlsqc
         z/BA==
X-Gm-Message-State: AOAM5318tr7yCVUPwMCusKQqUZ/LEZ+kiGWcjoaZgHdycew4eV7uUHdx
        LOV1zRsumphtACP9KJ5f+xGLkuyYfLV4JQ==
X-Google-Smtp-Source: ABdhPJxaJhQc1E1GI4ZOjM9kN7WMKJxNo7mJuOBcpIOTMwzlrx4OAnWGu5fGKdaElx3YrQlghpeSMA==
X-Received: by 2002:adf:9151:: with SMTP id j75mr30305889wrj.68.1630399226261;
        Tue, 31 Aug 2021 01:40:26 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::884b? ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with UTF8SMTPSA id y15sm2002528wmi.18.2021.08.31.01.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 01:40:25 -0700 (PDT)
Message-ID: <85959c1f-80d4-3fd9-f8a5-d7688e337e95@gmail.com>
Date:   Tue, 31 Aug 2021 10:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Content-Language: en-US
To:     Larry.Finger@lwfinger.net
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        straube.linux@gmail.com
From:   Michael Straube <straube.linux@gmail.com>
Subject: staging: r8188eu: Switching encryption to use lib80211
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry and all,

I'm currently working on adapting patches from the old rtl8188eu driver
that convert the frame de/encrypt functions to use lib80211.

Please let me know if it's not worth.

Thanks,
Michael
