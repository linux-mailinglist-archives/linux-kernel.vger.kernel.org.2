Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E6A388052
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbhERTKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbhERTKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:10:49 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D82C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:09:31 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z1so10160694ils.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=n//qGDirJD9obH9G3hvF0yOly+mUVRFHRac3HkYPIZQ=;
        b=HHwynUO+BYcb/EYBz12eEF0+Nd781lggA9/qxCoUOHozVRxwcodj8V8Hn9YhkEv9qQ
         N5yRFSeCAroOemxOAEwbWhvbaPU9035JQXSKHpngYfDqe4js8DfXApiUN+FrseQk31+o
         P3lvJ1CTrEXR4Q8TPrT28450ttAvxQU5EAVqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=n//qGDirJD9obH9G3hvF0yOly+mUVRFHRac3HkYPIZQ=;
        b=Rql+QsEk3BjI0l+qJ5rZhVZKunNxNLVCGgj5+jjXZIOqqPF2yA9+muWSUhpjIlOkFe
         lxDK2MbEN64Vt5hc9Q4oxu3a11TQv/gdZhiDtVV+taW/O9c+4Z28M4UjRTjolOldbERS
         plCYEkFKvKlp53yB0WMD99MYBa2a3RSws4TfrnrYH1VStUzsePr4q73oEjhQ2kLXD7+4
         34kKbG4P/nM+VJZY3MQOKy+e2r/Me/9hfuuPwHRlgqc+slycEY7R4j+gCrgHw83IYX2s
         724D6pPOk6M5YduLf57hB+KE9yXn/pjmIx0Znnv/x72WRHJmJ4DbitaCqO/tTyQVEWdm
         QspA==
X-Gm-Message-State: AOAM530TxN06FyRI+OAvDT+nKkHlZLtCBNzBXS0+m79mpJnOSnx6hSOD
        s6F+NHz+8i8JH/YtowDbIaYK889SpJjVV9Eo
X-Google-Smtp-Source: ABdhPJxbYsfYZBnyCHTxD9DBD1S25bVeRGL58ZcgL6bD2TNGSMzCrncSKZaE0Hl7di1ZKJBo1ul3iw==
X-Received: by 2002:a92:cecb:: with SMTP id z11mr2896028ilq.186.1621364970884;
        Tue, 18 May 2021 12:09:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x14sm10897470ill.74.2021.05.18.12.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 12:09:30 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Cc:     tech-board-discuss@lists.linuxfoundation.org,
        "conduct@kernel.org" <conduct@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux Kernel Code of Conduct Committee: April 2021 report
Message-ID: <448b06e4-41fc-26df-a862-c3ba2f70b6b3@linuxfoundation.org>
Date:   Tue, 18 May 2021 13:09:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Code of Conduct Committee: April 30 2021

In the period of November 1, 2020 through April 30, 2021 the Code of
Conduct Committee received the following reports:

Unacceptable behavior or comments in email (3rd party): 4

The result of the investigation:
   - Education and coaching: 1
   - Public response to call attention to the behavior and
     request correction with consequence of ban if behavior
     persists: 1
   - Public response to attention to the behavior and request
     correction: 1
   - Clarification on the Code of Conduct conduct related to
     maintainer rights and responsibility to reject code: 1

We would like to thank the Linux kernel community members who have
supported the adoption of the Code of Conduct and who continue to uphold
the professional standards of our community.  If you have questions
about this report, please write to <conduct@kernel.org>.

-----------------------

This report and the past Code Of Conduct Committee reports
can be found on the Code of Conduct website at

https://www.kernel.org/code-of-conduct.html

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)
