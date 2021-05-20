Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9481C38B1D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhETOiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232606AbhETOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621521418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3QdhlEV0blTi2w4VmxO9VckI70luGlKI3gtS3llsuU=;
        b=a4/l/o5kwZvN4vtSBbtHE6Q3WOERkKGn556gHgiSG6PGBVXLZD2O2PdGtuCkw9qX7pp5Id
        h9WmDT3+Fhp78WkA3MkvTkzB4s4eYQE62AAn0jGx+Lf1POXk0gdC2TilEvVAwb3mSBXknE
        bfN03SH1h/SYFd6VfdIqi6HMJ/rucTQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-sXu2wA9_PBWGyuzKmKI7LA-1; Thu, 20 May 2021 10:36:56 -0400
X-MC-Unique: sXu2wA9_PBWGyuzKmKI7LA-1
Received: by mail-qk1-f200.google.com with SMTP id b19-20020a05620a0893b02902e956b29f5dso12619026qka.16
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L3QdhlEV0blTi2w4VmxO9VckI70luGlKI3gtS3llsuU=;
        b=lJ/wFqR4lIFepsNiOS8tSGxi2yama3VxKiFfVTAqO8jZKXurAtRsMExaP5n5iUC0w0
         Mspz1tilPCzdCSDlyKrpKLi6VLuoXQHOg0mhhTXz8hVxbQ/Sx6Zp82fu87I1gAbbbHmL
         N7yWf8e0exnSWx5AVGl0NcyiNHjnU05B7EQvbDfrgEC3hJ3hg9oIaWm1iBWVIqFICi59
         zAfXID8tPo1mOap08UUduV4NjuLR6ITcirPsAbL6rk/HXDeKSJrVpGEpYJ7JJ6K4q6zF
         2+fPuoucA/pGXwJcpJ6p2mTNU3NDhM/0E9VdI8NGqMH/VjM5XioARcC8WQt5f4SToTIN
         BYSQ==
X-Gm-Message-State: AOAM5313BBQQxinRJysHUyCAuppt1ZvRJIohm/0RF7FSTewuTyD/ripb
        yniWTcpcCA/U5ccVTxz3Y32OWckluTb3UT6HWu/NxV7z80C5zFraJNvdRzwRF4uHSUgLaM9IIKP
        8pU1yAA02pR/672aL1nJ9QNCZ
X-Received: by 2002:a0c:ab88:: with SMTP id j8mr6038033qvb.23.1621521416001;
        Thu, 20 May 2021 07:36:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTOpSjEbg1fjWhTkhhyfhExJ3Rsio6SZuqbobWYJDGavFY/5GmDdlgH8BmFdoZIVA5+IHf7A==
X-Received: by 2002:a0c:ab88:: with SMTP id j8mr6038021qvb.23.1621521415869;
        Thu, 20 May 2021 07:36:55 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v65sm2213356qkc.125.2021.05.20.07.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 07:36:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] fpga: generalize updating to partial and full
To:     Moritz Fischer <mdf@kernel.org>
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210519204256.1975957-1-trix@redhat.com>
 <YKV55XK1Py5YSXZp@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2e79a2f8-1917-b7f2-4b19-2a742ba0e28a@redhat.com>
Date:   Thu, 20 May 2021 07:36:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKV55XK1Py5YSXZp@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/21 1:49 PM, Moritz Fischer wrote:
> Tom,
>
> On Wed, May 19, 2021 at 01:42:56PM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> There is a need to update the whole card.
>> The user area, the shell and even the card firmware.
>> This needs to be handled differently than the
>> existing partial updating in the fpga manager.
>>
>> Move the write_* ops out of fpga_manager_ops and
>> into a new fpga_manager_update_ops struct.  Add
>> two update_ops back to fpga_manager_ops,
>> partial_update for the exiting functionality and
>> full_update for the new functionity.
> Partial and Full are somewhat loaded terms with FPGAs -- think partial
> reconfiguration vs full reconfiguration.
>
> How about 'persistent' and 'volatile' or something along those lines
> instead?

I think that only applies to xilinx,  its all persistent for dfl.

How about calling it what it is.

partial_update -> partial_reconfiguration

full_update -> board_reimage

Tom

> - Moritz
>

