Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C213B429B16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhJLBkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJLBke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:40:34 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0F2C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:38:33 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h196so9138281iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3E2lZgR6WlfqtvFtqNr57xZdEqFDKbM7UDdFQZaAY30=;
        b=tJvrAjY0LdQyKl8FxIAs/v58IFcP0Huoy/xQYoyiq+6Hrr/xPQTJO+bOLJcwb/W5rD
         80fvGo/Hsev1ANQ3wuHwZQ+sRxg5/WpL2QwSZT114Vpn1A5zjl7mkdegNYkB23UVFNgc
         vSljFDNPXfKRDYV+CnCXnAvQTlgtp68dS1rYc0BC9lqhGjnEzqvJ1Sgzfh/XxooaPlUC
         HJiKANladNEaHHd6XbJCX6uOAcrio5ISsRun0GC8ZE1ghJcIs5+tPFEapwVKMctUHy44
         IwQWPMExPjNqOrAZ2O38XLO2QtHVb3McLSdNyW+qgW81d5TQxe+pLB+IWPmvbUqJer2R
         Y8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=3E2lZgR6WlfqtvFtqNr57xZdEqFDKbM7UDdFQZaAY30=;
        b=C0LGosTJnL+Z3LarF/VedLhE+FtYtr1fQ5eMaW4LVRnBrK8EjBCsRT1nNfF38w41Lf
         PC4hAoWU/ZORPD64XoMPf5sHvCKIzkXadx5ewf/ruhxpM0wdl8EiiuR21K1zSIdVzvgX
         2KzV6GgIctXo74uHz+WArItGH32zzo4QtKAUw0OhQb0c2whlIjMwl4BWh7oony9wo3CB
         5YMGZVFJnjyDjJLzRbXzF+fpjn31JdZkbFC/XWg5/Q0hzmZjphepUGr98J3IJ4vcsZUw
         K4PaPhnuwrmYVILPqcVgrLlQwdJPvzVJJJIY1BJkTbabu2oEpbJLhdFvtIoT5V4HCvel
         +4SA==
X-Gm-Message-State: AOAM531/cBfqdkY6ly81vIahg5jT73lcF236uodB9am0gvN2pMULvvX/
        XNIHdmG610IYT2ZBMKYdOx5kVJtDFCYJ6w==
X-Google-Smtp-Source: ABdhPJy4rxoGas4YJ1Xai/QQVAJd1k1Kp99/lCF542HiY63Ue4j4tEDlCmsfruz0aqb8YQWz/4Mjxg==
X-Received: by 2002:a5e:9612:: with SMTP id a18mr21258847ioq.57.1634002712889;
        Mon, 11 Oct 2021 18:38:32 -0700 (PDT)
Received: from [192.168.39.11] ([172.58.83.63])
        by smtp.gmail.com with ESMTPSA id l12sm5017090ilh.19.2021.10.11.18.38.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 18:38:32 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Rob Landley <rob@landley.net>
Subject: timer_create(CLOCK_PROCESS_CPUTIME_ID) for child?
Message-ID: <cbb6ce6a-bde9-dc16-b7f2-9bbf78d310b3@landley.net>
Date:   Mon, 11 Oct 2021 20:58:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to timer_create(CLOCK_PROCESS_CPUTIME_ID) but have the signal
delivered to the parent process instead of the child?

Possibly there's something that could be done with ptrace, but I'm not figuring
it out. (I don't want to create a timer _in_ the child, that visibly messes with
the child's state, and I might intercept the child's own timer...)

Rob
