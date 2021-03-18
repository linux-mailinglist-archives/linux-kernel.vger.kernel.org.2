Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1828C340A02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhCRQVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:21:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44071 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhCRQUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:20:55 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lMvOH-0006Ip-J1
        for linux-kernel@vger.kernel.org; Thu, 18 Mar 2021 16:20:53 +0000
Received: by mail-wr1-f72.google.com with SMTP id v13so20369804wrs.21
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 09:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZzHyZiP7q249349QnQTRfCWxuT/vhfc7B4spDMVzQz0=;
        b=uNoLhzeXTZBMd8f/Y5BQQvFt/6jlEIBBVeAp+HDQ4kotUPY7DR8/59DXAQo3NGV8Ph
         Vunw/6b8b/ESmPoQc/XSZMqjr9Y09LOYGEjv0ORV9d+oIPlrLtPbwiuVC5hZnHGVoOqm
         3RZhiJxRDPKjTGkMZBoesN6Zc/vTCZB7cW2VcyEYZIAUl7HnIcpstwJhCBNMs3Mc+7la
         5Y4tcvNvk4lk15cNSslEj5dWTDg3l51debI0vrZWt8VhQhtRh3ZvMf3E2jqxx9HE5bA7
         wzc3/MkZC/jTvT1vCvhKNouZdjvkmPMoIr2KVeyNsgKwAbxq0zb5lWNzog7Ih1qXJg1Y
         9rBw==
X-Gm-Message-State: AOAM532dUVfo+uFMUhg2MIzW4olhmRY3y225lxCItfLKNyY9g7aumyJD
        ris+G9j+gTDUxHmnbOfDG41Z03EdxpeG4/cWA4ENRTNkLQDMo5zgcRcEr9PKIyBp4ZCY9hnyAOg
        ulc1pQC3zqIE8xcYBDUMXuw1MUvwV+83/QPuUDUZdCw==
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr50268wmq.73.1616084453299;
        Thu, 18 Mar 2021 09:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1DpeLXYiW1I18/I0ZlN0TTxX4pn4vUI/YgGtX9kIOuZ84jxL1Z6siAJbnotuq/VVZh43bsQ==
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr50251wmq.73.1616084453095;
        Thu, 18 Mar 2021 09:20:53 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id r26sm2771392wmn.28.2021.03.18.09.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 09:20:52 -0700 (PDT)
Subject: Re: [PATCH v1] memory: tegra20: Add debug statistics
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210318115556.22792-1-digetx@gmail.com>
 <acdbd1e3-8f38-1ee6-0980-3699df9e4375@canonical.com>
 <26ef74e0-67ff-77c4-1682-8f8261b71463@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9a634d0f-b12f-8b4d-8807-56182533fc3b@canonical.com>
Date:   Thu, 18 Mar 2021 17:20:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <26ef74e0-67ff-77c4-1682-8f8261b71463@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2021 17:18, Dmitry Osipenko wrote:
> 18.03.2021 18:23, Krzysztof Kozlowski пишет:
> 
>>> +
>>> +	/* collect memory controller utilization percent for each client */
>>> +	for (i = 0; i < mc->soc->num_clients; i += 2) {
>>> +		client0 = &mc->soc->clients[i];
>>> +		client1 = &mc->soc->clients[i + 1];
>>> +
>>> +		if (i + 1 == mc->soc->num_clients)
>>> +			client1 = NULL;
>>> +
>>> +		tegra20_mc_stat_events(mc, client0, client1,
>>> +				       MC_STAT_CONTROL_FILTER_PRI_DISABLE,
>>> +				       MC_STAT_CONTROL_PRI_EVENT_HP,
>>> +				       MC_STAT_CONTROL_EVENT_QUALIFIED,
>>> +				       &stats[i + 0].events,
>>> +				       &stats[i + 1].events);
>>> +	}
>>> +
>>> +	/* collect more info from active clients */
>>> +	for (i = 0; i < mc->soc->num_clients; i++) {
>>> +		clientb = mc->soc->num_clients;
>>> +
>>> +		for (client0 = NULL; i < mc->soc->num_clients; i++) {
>>> +			if (stats[i].events) {
>>> +				client0 = &mc->soc->clients[i];
>>> +				clienta = i++;
>>> +				break;
>>> +			}
>>> +		}
>>
>> Could all clients have 0 events ending with "clienta" being undefined?
>> "client0" would be non-NULL because of loop before.
> 
> As per 6.8.5.3 of C99 standard, the declaration of a for-loop "is
> reached in the order of execution before the first evaluation of the
> controlling expression".
> 
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
> 
>>> +
>>> +		for (client1 = NULL; i < mc->soc->num_clients; i++) {
>>> +			if (stats[i].events) {
>>> +				client1 = &mc->soc->clients[i];
>>> +				clientb = i;
>>> +				break;
>>> +			}
>>> +		}
>>> +
>>> +		if (!client0 && !client1)
>>> +			break;
> 
> this means that both client0 and client1 are set t0 NULL here if all
> clients have 0 events.
> 

Yes, you're right. I missed the assignment client0=NULL in the for().

Best regards,
Krzysztof
