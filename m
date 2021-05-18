Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C10387BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbhERPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbhERPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:00:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AE2C061573;
        Tue, 18 May 2021 07:59:20 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c10so7623735qtx.10;
        Tue, 18 May 2021 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ArK/pW6s0JbFtIQZsomVHDIuB32ppNzwcnMzDXtwDbg=;
        b=ibLVz/WSekjCtSFiyr9Kvz33zseWk7WWA3fcm2fBBH9mKLlnlwdmPjUSUF7vzHTHxE
         rM4MFOfAvBU0bLveeRqp1q2vv5vl6Og7lX+l0NXxlCC6MmWE6UsDNryRpvIQtdQ54VQH
         OfbNokofWCwpzMHjjqP18BBA5+YmVaNvByDlByf75ud+X/stNtxTjvh995rbysNvu6TT
         SvDbdFNG1P1TBjO0p78HqE0zCnnq95ubJm+iZ4t+/GKduH2NVYr2M52SnIvo4Uhc23iZ
         phc3NimRamxyzrPsdMEZR89sxNM782zVXG6ZyJCS/NhdZFxx+sZV4KD2K8GHiSwtmmjB
         vixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ArK/pW6s0JbFtIQZsomVHDIuB32ppNzwcnMzDXtwDbg=;
        b=m1I9/myr0OqC0e7/iwIaXp4haRbjy944kDsM7jImN2251IuNoQyCcuMHzT17QaT5pJ
         qhoMVXrf9bwiJBgxpekLLb75vO5OnENjdoSIwvb5SN0V9+a24ShR4CPtOnWFFOUOKWnU
         cSK/9oLtzPKAq6eqvxHn74K0W90aF4eLkuBFeSpb2L39Mnrl5mmURCJHGlHMkz0lq5lr
         OHOhRzKrWnGqGu2DgZNN8FKtr/fzG5is3FalnRJBycO1BXPZn5LvCeJygV8lQnNdj0hb
         M3ZH6e43+WpJrbjEA1Xtb+U1UcKypm/Rwa5hL3VoR77dk+WsZ2NqBMHfPiT5MXfiPyb+
         LkFQ==
X-Gm-Message-State: AOAM531Cpgi3sxhBhHmSLBdfghcdTbUNMypkaP63pfuoarj0EcJ/xFK8
        WRJQP3P1Gtf8Mo5943V7Thut710kCms=
X-Google-Smtp-Source: ABdhPJwhQa66o5ukWn3BIpYj3XMm38KiQeOThE7FD4DpWRNY8iKjGIRXlZjmsJtg54zgq5W2opugYw==
X-Received: by 2002:a05:622a:11c2:: with SMTP id n2mr5098035qtk.375.1621349959676;
        Tue, 18 May 2021 07:59:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h23sm10915077qka.22.2021.05.18.07.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 07:59:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210512013052.903297-1-kubernat@cesnet.cz>
 <20210512013052.903297-2-kubernat@cesnet.cz>
 <CABKa3noSQVtAp3Ath9=PNh2cDLgq8n8w2gudwWJerD5YQx5WMA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 2/5] hwmon: (max31790) Fix and split pwm*_enable
Message-ID: <5d60960b-bfa0-83d0-0268-d1610e2df9f2@roeck-us.net>
Date:   Tue, 18 May 2021 07:59:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABKa3noSQVtAp3Ath9=PNh2cDLgq8n8w2gudwWJerD5YQx5WMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 6:32 PM, Václav Kubernát wrote:
> Hello,
> 
> I have updated the code and got rid of the "fullspeed" mode as
> requested. Let me know what you think.
> 

My major problem right now is that I can't reliably test the code, and I am
only going to apply it after some thorough testing (especially after the
problem with regmap volatiles in v1 I'll want to make sure that volatile
registers are handled correctly). I am working on improving my module test
code, but it will take a while.

Guenter
