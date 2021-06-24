Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F2E3B372B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhFXToV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhFXToU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:44:20 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB0FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 12:42:00 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 84so8656725oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 12:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2V52nMoPYeyFa3WPI1Sxk5DnaNe0woUXAG3iUUVQJYU=;
        b=JYLM40IP8Plzhy4ZxC44UAkOa53TTw8JEn31QPZDApD7+ttyJkQyQaZzVpQ1PWiWpm
         C88wpxxzx6yl3CBKq+xfv5j9HEwEWUVOIRV1+LPaVbsE8y4GZ6q/WqIvmXxnNsow0P9t
         5zbsK69Zjar16zcL/LtBKin+tRZyCPm0UUL24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2V52nMoPYeyFa3WPI1Sxk5DnaNe0woUXAG3iUUVQJYU=;
        b=qQQtpuvwFBj6iuv/1Ip4hg+OgP4KX0dovZzl4YAJEJaey4R7IYm4r3T4Oox1olyYnC
         oVb/UHQtdJZDsNHSsUvU2bLrirlP1Ah7A4W15LiVVyk0sGaTzytuTw0DsbKP+PV3Vbdf
         sHzDL8Yyvle1dP/woUCbtAkuC4FL3haCgbN4PpHJXJ9e3XR2qOh1mJgWCGU70ViUf/vb
         AWdQiT8p4/+Cgy69ldDzrqiEY0USjThO9uNqFqOY9yg1f8asfwoUxs1NTPpEgUwwKect
         ajymQcMH+LHxRviJAhtiT580Ym81muNHccI7Byp81hFOAvPar6mx0JzjYDMkug7eq1Qy
         B/vg==
X-Gm-Message-State: AOAM530CEvby0DZFxrKT/G56G/Kp/WHu0zkBFdkXc+CIZ6fnUIJpdpAs
        raVWca9zREWT36fh3vaXRxARtg==
X-Google-Smtp-Source: ABdhPJw2JK4IMPf5cPuKhePSf4gwZ74/9E8kx8HMjC/QYhmfAc1LaFzojcGWM56VoqIGkcurYSbc6Q==
X-Received: by 2002:aca:aa17:: with SMTP id t23mr5674580oie.89.1624563720243;
        Thu, 24 Jun 2021 12:42:00 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d20sm849913otq.62.2021.06.24.12.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 12:41:59 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Cc:     tech-board <tech-board@lists.linux-foundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux kernel community research
Message-ID: <a070b6bc-6bff-092a-be15-ddb18f4c174e@linuxfoundation.org>
Date:   Thu, 24 Jun 2021 13:41:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux kernel developers,

Kate Stewart and I have been working with a group of researchers
to
  assess how effective we are at attracting and engaging a diverse
group
  of developers.



The goal is to take  the pulse of our community in general and
  to
understand the reasons for stopping or taking a break from active

participation. This will help us get an insight into the challenges
our
  community faces.


The research team developed a survey to help us with this effort. We
shared the survey with the LF TAB and folded in their feedback.

I am reaching out to share this research idea and the survey to request

feedback from the community. The survey will take ~10 minutes of your
time and your
  responses will be anonymous.

The survey can be found in the following link:
https://wfoss.limesurvey.net/846628

Thank you in advance for your time.

thanks,
-- Shuah
