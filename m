Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7D33755FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhEFOzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhEFOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:55:34 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9740C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 07:54:35 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q136so5141804qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONw+m9Aj9DrqajdNs9lDDlKWZxRvhGUtNfmBdcikAZc=;
        b=gk9IcW0cbqmgLxZxzE47jd6ql3mfqSFpg02J47Oitbsyb11xJp6txA+F1L6DCw1IkE
         /w85NTH8h3Sb0uAYjNBkFKUh6sXr/rR7SK4VqvP3KQRGPc2c6O05519SZTwsShmc2iLZ
         0sAejjcxSAA3QMp7VeDybU7aGiw+RIQgQ/l5FszM1sebZUhyfs4V16pw2jWRfXPt3M20
         hwN8OhJLvI9UbGAaBFUcq4nbEgud9RFkVERsl7DvyhSMcMDFLJxV1LWCqIaEsKS3HgNg
         K/trjG22Yi6uQRy+p6C7awgBsAD6JVFLPHJ24vp9gVeOdfFAMjSaYHEb03gWuSE6OJ32
         jvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ONw+m9Aj9DrqajdNs9lDDlKWZxRvhGUtNfmBdcikAZc=;
        b=I9hxXBXaHX7Ktbt9Kb8Dojfj4/7NOWWbp8Gru/3jk3GJINtbxCCUETOeF4NtVASs94
         2lDUJN985brVFaq+LUo7DqlJLzylSJDfyTBlx4tchSfbpFc7YG/x6NOXwmH+gj6No23C
         vGukvOMNMUQdU9cFDYheC2Fi5rosZU3atHFpFlAqEzOjfUVQo/vEbhYlQpaOk5pKx0EQ
         hdBPsD7IN6lA9xwjdzr9HvfpwjNAlvXjyciPXyP9SvJcJ2npM+TgecGTe9P0MDg7i6TM
         gHklZIAxNGLXD3PzFKpTWPBAzrirINoI0lYnL8A6d5Rn/BMz3ROOFV4jVQ+Q0523g/0g
         yNzw==
X-Gm-Message-State: AOAM532yYzENa8+VpuPrnxgK9Z5xe09xiiHbPKKXdZijq1ciH+0xXWnQ
        Q18CIm9gSi9+jQieiurJZX3MFtYQsPV7s79hWrY=
X-Google-Smtp-Source: ABdhPJwYxFzVWIzhazQ3t3WxV05BA1jR2S1HubT6CcPn02M9uJvd8g2hGsyt9qyDBszvNrIYJHW2gA==
X-Received: by 2002:a37:a854:: with SMTP id r81mr4196187qke.83.1620312874870;
        Thu, 06 May 2021 07:54:34 -0700 (PDT)
Received: from iron-maiden.localnet ([66.199.90.164])
        by smtp.gmail.com with ESMTPSA id p187sm2263691qkd.92.2021.05.06.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:54:34 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     corbet@lwn.net, hdegoede@redhat.com, Jonathan.Cameron@huawei.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] Fixed typos in all directories of Documentation/ABI/
Date:   Thu, 06 May 2021 10:54:33 -0400
Message-ID: <5458216.DvuYhMxLoT@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <YJPvl6Si9Xi0w5tG@mit.edu>
References: <2219636.ElGaqSPkdT@iron-maiden> <20210506084237.1f8363ba@coco.lan> <YJPvl6Si9Xi0w5tG@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello both, thanks for the feedback. 

> > 
> > (not a native English speaker here)
> > 
> > I'm in doubt about this one. The description is talking about the
> > "VPD format".
> 
> Maybe "badly formatted" or to be more clear, "some devices may be
> reported incorrectly forrmatted data"?
> 
> 						- Ted

This looks even better. I am going to change that and use the chance to send
the patch again with the proper changelog (v2,v3) and Subject, as Randy pointed
out.


