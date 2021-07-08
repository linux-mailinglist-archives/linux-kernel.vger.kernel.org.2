Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5453C1894
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhGHRp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGHRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:45:57 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C224C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 10:43:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 14so6527504qkh.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akExZlXfzzWeEV1vONzULN7Ly/6NeGtVmi8mRpEDmf8=;
        b=MYsablPH0SXJSuED4xm417ftbm/7N7QfvP8SikmFuMTOS2BB5V7tIpQ1YadoPJJo+0
         UPNc6MrdAuM4kSI86b1WIdJ2lNvxpn7CeNTzfsDR+tYCRq9Gi5pXebHhHZtOqEZDvdYT
         plixrbg4URQzPOwSI+IKmKHwRvRQbU3uMT57WQt2eI6l7H7eukPos8cUVyhKhRlak3WN
         KHxAYJE3CvEMnAgHjJ+dOXcLFRdgIx4yw8bHszChDe4Acck7S/DTOHxBruD3I0xEJCf3
         +ET+IomWMrjjtVF0ECd65wfY0YseV+3NcSsB4MAok4HzbVxgwGGX1HJ5oheWoFsIhxrM
         OsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=akExZlXfzzWeEV1vONzULN7Ly/6NeGtVmi8mRpEDmf8=;
        b=bE5XQAgnLXpSYWQRlNKhhoU1Gp8xm6cQ7TL2JjFUKKHprVW/U/rMpOHKGr+Gc4lQ0+
         9wLSRx+jRVM4G75HX8TGXm1MqABvbIqNOY01IVDAik4ylraLFyn3HKXFFNzwi2LOK6Ee
         wIjeIWQMWmXSVYNBF3ooghwg3iMSbySX3PE73BeDm42z9m8O5QVQU1CAruZ26+QZrqbs
         1UEcToMOxrorvYd3dPFYgdMsmCYmk+KchkcA6ZWpGVxy7vVyc+ncPmCjHKplDl6l5V8Q
         fTvt7XsnJJR5PbdwKgLwsa0dFgjg+n2ZZSwH6AD2eTA5LOoDojDetrwpITY5som6kdjX
         PKNw==
X-Gm-Message-State: AOAM53345JME4B4Qwi7OdGX+oskxsc001+FM95vP5rKmXIxL0Jz016EJ
        mT+QuS393jGqShvb9wgQNn3e3Q==
X-Google-Smtp-Source: ABdhPJyYsm1/iLiWMKCdcfBEnN7MW1bhFmg5WCVlAl/Wr88/YXS3yjWT/qM/xUOpH1oLO+Zfnax5iA==
X-Received: by 2002:a37:468b:: with SMTP id t133mr32258137qka.189.1625766193206;
        Thu, 08 Jul 2021 10:43:13 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id y4sm1280556qkc.27.2021.07.08.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 10:43:12 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     davem@davemloft.net, Joe Perches <joe@perches.com>
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v2] drivers: net: Follow the indentation coding standard on printks
Date:   Thu, 08 Jul 2021 13:43:12 -0400
Message-ID: <1718548.TLkxdtWsSY@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <ccf9f07a72c911652d24ceb6c6e925f834f1d338.camel@perches.com>
References: <1884900.usQuhbGJ8B@iron-maiden> <5183009.Sb9uPGUboI@iron-maiden> <ccf9f07a72c911652d24ceb6c6e925f834f1d338.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

I apologize for the mess, I will send two different patches for the drivers now.

thanks,
Carlos.



