Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF661321D38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhBVQk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhBVQjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:39:14 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F48BC061793
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:38:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id e6so898594pgk.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=7nEcqNWP9KeLsneDEi3dmHkpomc3q3iTlP5gSWNfAcQ=;
        b=NuRJOzgrpD9NqUtdPgEpxKQ0XI29kNDHiXMOsWkKeRv4vIT6UOUUViSB77N8yNK8Tw
         GFE9XxCv3h4I72Vii/Hfemo+Z1GkIRW/MX+xgtzo6sEjN3pOLDQ4ub8vuTsFQtg5DuJp
         3mrlLg9HzUdmqkJO0YcZ2TYM6EBo0QYDXIu1ziD79mEEFNpGGfhCEphulrA5LxMuaCct
         boNOEVAAwj+7gKkFLwkfF2bXxjb+mmSjeMBWahcNiATNESP9k1QVXIaCNjhyRmQ19ChS
         0UFS6jiL4fFrBp59taemkS0doekVcz/DDKYErDI+SkrmjrXDsWSsVlAz35Dg4440LHkg
         jk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=7nEcqNWP9KeLsneDEi3dmHkpomc3q3iTlP5gSWNfAcQ=;
        b=i37YLclHucsB6ui9w49VanJ1147du7/ZEcPPNCUm9lP22nY5aHWNqw3UUA6bV6PPSy
         GaaR9tHljgwveJzVB8nAbHSwYGiq6ZWYS9Vn/PjdfrODSQrgkSX3aPBv37siGXfhvOG7
         eEM9W6TlUGN7gTKK55dJ3y+fByYMO+d+WJCn9he5RXAfMx/UyX9Hqp0RupwOiWVTkd4v
         2LrGPj5S/lx0y+HRjzrf289G7GlN0Dgdz4YFgw7it/M9fVpQYambP08mUwh68PextR6P
         cvGI4L/dEfkU63rDn3Lxxzh57kFy+57vBtrCtDCv9aMkb/Z34itdzwe1FEQmpCiNewJO
         YtMA==
X-Gm-Message-State: AOAM530x/kFFZgPM8oBU/7idxKsIWccFHd231ucxu9pMQU+JJ5czJZrR
        FPEzqM4cHbChOhHpxY4Sr1uuwsgD/uL5yQ==
X-Google-Smtp-Source: ABdhPJxqz34ZM94yk8FiSaPW1f7exsvyw+uudqITNj/3zOoPWWNpd9mszS+dKRCZOchryezrJByXtw==
X-Received: by 2002:a05:6a00:1385:b029:1be:ac19:3a9d with SMTP id t5-20020a056a001385b02901beac193a9dmr14966529pfg.65.1614011912396;
        Mon, 22 Feb 2021 08:38:32 -0800 (PST)
Received: from [192.168.0.6] ([103.16.71.222])
        by smtp.gmail.com with ESMTPSA id 8sm20544932pfp.171.2021.02.22.08.38.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 08:38:31 -0800 (PST)
To:     linux-kernel@vger.kernel.org
Subject: Wine List
From:   Gavan Hunt <gavanh@dynamicaims.com>
Message-ID: <5f5b2bb9-df95-fd6f-e758-e6427ab68e5a@dynamicaims.com>
Date:   Mon, 22 Feb 2021 10:29:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Would you be interested in acquiring an email list of "Wine Enthusiasts List" from USA?

We also have data for Beer Enthusiasts List, Liquor Enthusiasts List, Beverage Enthusiasts List and many more.

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

All the contacts are opt-in verified, 100% permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Wine Enthusiasts List.

Best Regards,
Gavan Hunt
Research Analyst

We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject "Remove".

