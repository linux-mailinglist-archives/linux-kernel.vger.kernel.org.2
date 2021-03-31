Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7DF350606
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhCaSKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbhCaSKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:10:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862EEC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:10:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e14so8321625plj.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CRwTprnnI8wz+/z7qaTV17ZDi+HLSj0ilkKWjBU02K8=;
        b=VPaEWj6gEDKV2/fVYPM6pBeCCmjH5CjUv8MDPhK+OFLA2zwsAWG/NkWeKzZStAo4GB
         ccHdr3pCFCCtk6TdaQnzqtjSEnGZ83/QUQk1H6coKIXXsbFng0x/EdaWPa5gzO2xAwbH
         ym9PALE98UahaphLi5qOR7TpbNea4i+jq5/Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CRwTprnnI8wz+/z7qaTV17ZDi+HLSj0ilkKWjBU02K8=;
        b=mCzMzfNN/Bvkm7puwAVBWBkLdWvEFz1T5/a08yLZSXJ5cUY/hIWTIptMifhUNFyFUw
         7xFsy7DPmanJxiDYD44tqW0GfuyU+DJ5bouYK4RQLWMSPBOZyQLO6thTHy0qW8CvQO0o
         4lMBU63NUJVRlVJAlm6os6uUlFpGsc60qSj0v4icd+XdTyNfagvM2f7z6dztgZo5Fq7f
         Rvz/KS4ThSScQ7n4lz61kL4vHFfm4PDAM9QkNO8xC/7x/s3nacy2MGx+h2gmJRXO2qoe
         S16VOwz6ZpbvFX6NL+UV7DkYlzdiZG40mwhDtKC7Rtn9SZkxQfdHE2As8JDzrUo7/p/A
         nNGw==
X-Gm-Message-State: AOAM533N+TYrh9L6frbSDxA+GsIQ2pHZ+7x812P4i0s50ekMUqS9nTTu
        VFij6/94tnpep7TrfwODHnQKrg==
X-Google-Smtp-Source: ABdhPJwbAA32TMbB3osF08sK5TFLMQEjnc+42H9avoEUrbO+Zx4wBht1hAmZNc5xM2IMK/M2zLeYyA==
X-Received: by 2002:a17:902:c643:b029:e7:3c10:4695 with SMTP id s3-20020a170902c643b02900e73c104695mr4370404pls.41.1617214204060;
        Wed, 31 Mar 2021 11:10:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:74b3:8070:8b1:c494])
        by smtp.gmail.com with UTF8SMTPSA id i22sm3214254pgj.90.2021.03.31.11.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 11:10:03 -0700 (PDT)
Date:   Wed, 31 Mar 2021 11:10:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V3 2/5] regulator: qcom-rpmh: Add PM7325/PMR735A
 regulator support
Message-ID: <YGS6+OtDJe4E+jTi@google.com>
References: <1617192339-3760-1-git-send-email-skakit@codeaurora.org>
 <1617192339-3760-3-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617192339-3760-3-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 05:35:36PM +0530, satya priya wrote:
> Add support for PM7325/PMR735A regulators. This ensures
> that consumers are able to modify the physical state of PMIC
> regulators.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
