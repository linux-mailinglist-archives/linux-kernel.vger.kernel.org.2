Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC2C327364
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 17:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhB1Q4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 11:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230461AbhB1Q4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 11:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614531275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjLA4nLQuNboPUcqA+PfEQqcvf8BclIQy2K65Ac7xN0=;
        b=ca4KkQvgW0XafssRoTxLahgvX+UwPQkIApeChpWY1KIKHSs5sIkE6zBl8i8wERQNPUXx12
        03cSjGZjC9u6QpG7kpXPVAGdh4+bI0f6JJM9JUmEkB2L1sMAwj2bk+aD8dzTLkSZA5H/z5
        nqZCOhx0kMrEfEid3K8CDkN4FlIQ1v0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-vCwa8lU3O-ClYkqSM9-Ljw-1; Sun, 28 Feb 2021 11:54:32 -0500
X-MC-Unique: vCwa8lU3O-ClYkqSM9-Ljw-1
Received: by mail-qt1-f197.google.com with SMTP id d11so9353366qth.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 08:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xjLA4nLQuNboPUcqA+PfEQqcvf8BclIQy2K65Ac7xN0=;
        b=YqMwjHELJIxLrJAJXT6Z72uw7TMrqWsEeKrTDzsRrTfMpw/NNEQ9ooZ4qV0qH3Kjvn
         bl0tHJsxx3I1AW3lu2Czx72thj05pGWu8i5fuel6yQgfNKnzOf5i4XdGxHpgZJHAkBqg
         nY0roCFj2FJH9GSORFR3dH2hRaPJqYqiQSss1cI/4I61a/bEILcOpcGD131knvXF9Ll4
         IvnUnD64gvwSEb0UZmGy79M6nPzdKPixT0+hr8tyJhxvnRoqFy+CtzZ8sGCj5JDWww4d
         WscayvOUYNf7kTuMIGPk7k1TlLVJN0yppk9MQyLRccs6sdp+TSUUd224NvhEw4JJmgjn
         Gw3Q==
X-Gm-Message-State: AOAM533ZjWCftBcbimEnHH+hnXIwCQNaMBs4ugOOd6m5yqWU1KVZ4ta3
        0UNf5Re3kobB7H49S1nKTy8OoYsWjn7zvB3kvCKChuhQaxDHjKsaPUKVhajLMFVxcoDgR7JhUqR
        T4MelBE9og50gvSyjiA0p3PaL
X-Received: by 2002:a37:a350:: with SMTP id m77mr10921307qke.146.1614531272442;
        Sun, 28 Feb 2021 08:54:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw32NLOYnZg4CsaKO7EG+7dY3zL8r+1Y5vkqHr7/ySmieQHsLbh+nJyisNRbJY2ra4+NJlilA==
X-Received: by 2002:a37:a350:: with SMTP id m77mr10921291qke.146.1614531272237;
        Sun, 28 Feb 2021 08:54:32 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q186sm10807279qka.56.2021.02.28.08.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 08:54:31 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 03/18] fpga: xrt: xclbin file helper
 functions
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-4-lizhih@xilinx.com>
 <4628ef05-27d1-b92f-9126-27a1f810c608@redhat.com>
 <3b73400c-cca1-60af-4eea-ed85de77a977@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c79176af-8d0c-2300-3e4a-dfa604f10a62@redhat.com>
Date:   Sun, 28 Feb 2021 08:54:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <3b73400c-cca1-60af-4eea-ed85de77a977@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/26/21 1:23 PM, Lizhi Hou wrote:
> Hi Tom,
>
>
snip

>>
>> I also do not see a pragma pack, usually this is set of 1 so the compiler does not shuffle elements, increase size etc.
> This data structure is shared with other tools. And the structure is well defined with reasonable alignment. It is compatible with all compilers we have tested. So pragma pack is not necessary.

You can not have possibly tested all the configurations since the kernel supports many arches and compilers.

If the tested existing alignment is ok, pragma pack should be a noop on your tested configurations.

And help cover the untested configurations.

Tom

