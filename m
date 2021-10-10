Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C352E42842E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhJJXxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 19:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhJJXxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 19:53:40 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1CCC061570;
        Sun, 10 Oct 2021 16:51:41 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so2127483otq.12;
        Sun, 10 Oct 2021 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KnJGehr72FMcQg0eBMDYAYtXZrsYa5O5D2gXyYx+3Zw=;
        b=hfGWRH1OteNaFHbatjy8/7IP9WJirHj+1ahq8MTxFis7a9G4CWhk0pC0nA5mfz1rGP
         c6f26QE6noKckihQUHfcbXLQfwSzDAFZPt+Y891kI1Y0XisAtAqFy0NxJ7VbfmhWtgKh
         HO6fsdsVko/DG7NlEHjol1pFEb2yU7sXU59b8H9b9SkovbNa/gW/0o1XyGRyxN8R4QJR
         H3mtChrCJbggwNCrJaaVKTH7H9R7kMqHPljqDRT6A7CD4bmIJ/WGqTp4kn9VS/tGaouT
         UHe+okrK+yzdePhKBwr8z4znrWxa+S2hftFDSwZJYn/jA8BqLoWboop7vgpolO6gaDo4
         iXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KnJGehr72FMcQg0eBMDYAYtXZrsYa5O5D2gXyYx+3Zw=;
        b=t8krrLWWOVlg5Hy1yzTGfz25c07juWbwRiqhz2J3aDAggfdk7OkQfRysO10kOHNrTt
         ZUErRp3TOkITPcyjK8Ef0rX8I0RJXmzqhhJV0W9anU8UPerr/8ElbLj5f5ap/0FPP2rV
         MjdLQ6C9eX/E2AcRnZs60BlWorwmeQeKget3PZtvemvG8nF61Spy/PClv860Mv6TPuUZ
         22B4F4KUUEqfxrLTqpwQ/zZdJyZz0DMw0mTknwGC4pEW3f3LVTd86843CRDcEQo/t5mk
         zbiKtaRrPSDX8Dq5dZIwj0Iqo/nqgx0TviPOhKipjzidcibOvFvvYt7mIVcVPAYjzeBX
         pFVg==
X-Gm-Message-State: AOAM533L0cqx49M9p4M69PEHg/1AeK0+hLBDT0ByQKaggTQ4cAMf9QLg
        78d7IMXIIkpWEk/NgYCOF3CK3Ky4JEg=
X-Google-Smtp-Source: ABdhPJzFFRwMlHH2RcBLPYb4meszj7yQy8whnHqnVmFgnBh1m+O+aNOhMdNuXQpHY9PpK0cuAQ1RZg==
X-Received: by 2002:a9d:458a:: with SMTP id x10mr18588001ote.267.1633909900137;
        Sun, 10 Oct 2021 16:51:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s7sm1362335oiw.27.2021.10.10.16.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 16:51:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, platform-driver-x86@vger.kernel.org,
        Tor Vic <torvic9@mailbox.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211010210513.343925-1-pauk.denis@gmail.com>
 <20211010210513.343925-2-pauk.denis@gmail.com>
 <CAB95QAS863M9Lu3e0Um25PQi_7gxWp4=EyN8j7ioB7eN-G7--g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <09a81782-1ab6-662a-01c4-0f6dda1d26fb@roeck-us.net>
Date:   Sun, 10 Oct 2021 16:51:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAB95QAS863M9Lu3e0Um25PQi_7gxWp4=EyN8j7ioB7eN-G7--g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 3:09 PM, Eugene Shalygin wrote:
>> Changes in v4:
>>   - implement wmi driver instead platform driver.
> 
> There are many ASUS boards where the required function is present but
> does nothing. With the WMI module alias the driver will be attempted
> to load for those boards (and rejected by the _probe() function). Is
> it a good thing?
> 

Drivers failing probe with -ENODEV (presumably here because dmi_check_system()
does not find a match) is pretty normal. Board detection with the WMI driver
seems much more straightforward/simple compared the previous version with
the platform driver. Maybe I am missing something, but I don't see a
problem with the WMI approach.

Guenter
