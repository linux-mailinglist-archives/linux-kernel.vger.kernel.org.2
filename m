Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1296434F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJTPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhJTPfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:35:24 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F9AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:33:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id bk18so1166631oib.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Rh8sfF55xKFa3qLy2K2yALuwxTYLLjg26I0cnMrNZ5o=;
        b=OpMQVcb83wpRjjVs0vAi4Zh2/qPV3FFg1L6JMT0JvOOUKp6hl431KjZL6AsBICII0W
         n9KQD1JIuv0OXwHU+HvX0eXg4f54nH23lhBkPwGe0q0pdQNdeVPLWKN7j5bWf6oCcErw
         AX3O7gfbeMZpfTgxWw5KJ2PTdsopt4HWUsgt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Rh8sfF55xKFa3qLy2K2yALuwxTYLLjg26I0cnMrNZ5o=;
        b=i5QTQexHhk28g7JLIqL4AFND6aaYT/r7ZpeSKx7QP3ichTOAafwoEvO2QtB1Qtdf9V
         xzMfqdkeYEmDQP4KXN4G+RkNR6PtBiNUZqBtiNKcVJa5V1bHxlsWxpC/G7LzZ9h8Edo2
         72pCF7Fi0+Y8cz5w8bMmbKiNPTq4THXEsubRSEM7IM7JbyR7EsT6vbbtpDJLLKM8bQBi
         0kOneXzC2Ye3nF5AZx0rfLnNdoHD86kOYBT3df41IQxKrW5oUCrdMbrO94ApEsczlJb7
         gf5hlP6PN3fatp9sA1yXW+X81QJCO0BB52mPyb3OlpZjPeTDTH8N/rY88mIOZ9dC+ev4
         lITw==
X-Gm-Message-State: AOAM533W1jWLq7Xeov5ZjSYmhz/C0/j/Ju7dzt//cbkiBN5mEg2uc7vE
        6Sbh1175zvnhjbgFWE4A7DM/mdtPo3/DcA==
X-Google-Smtp-Source: ABdhPJwfyuTTWhMrEYmplu/hHIJdkZaYZf/+KcnQJ1WE/ytdx8UDyKyn1B5RGMrKU9svZVUuXujDUQ==
X-Received: by 2002:a05:6808:f07:: with SMTP id m7mr20174oiw.150.1634743989250;
        Wed, 20 Oct 2021 08:33:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q185sm37501oib.26.2021.10.20.08.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 08:33:08 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
Cc:     tech-board-discuss@lists.linuxfoundation.org, conduct@kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux Kernel Code of Conduct Committee: September 30 2021
Message-ID: <e81f0726-5f8f-f10f-d926-a9126941d38e@linuxfoundation.org>
Date:   Wed, 20 Oct 2021 09:33:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Code of Conduct Committee: September 30 2021

In the period of May 1, 2021 through September 30, 2021, the Code of
Conduct Committee received the following reports:

Unacceptable behavior or comments in email: 1

The result of the investigation:
   - Education and coaching clarifying the Code of Conduct conduct
     related to normal review process: 1

We would like to thank the Linux kernel community members who have
supported the adoption of the Code of Conduct and who continue to
uphold the professional standards of our community. If you have
questions about this report, please write to <conduct@kernel.org>.

------------------------------------------------------------------

This report and the past Code Of Conduct Committee reports
can be found on the Code of Conduct website at

https://www.kernel.org/code-of-conduct.html

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)
