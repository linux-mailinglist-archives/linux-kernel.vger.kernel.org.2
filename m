Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489263EDA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhHPP5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233740AbhHPP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629129401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZpQLZMB7RJdGulqivRZelq1MarObE9Ch/tXNewyPHo=;
        b=Hvx30XrpMwS29fa6qCHcCuCc3q+zerWlroiA7O/Z9oTrbhWAC7ZHCPKqzoNp9YyOWRkZTu
        q2x/qlZ+T7KJ2eRWNLOP9EbC7MeAjEbBSqSc/ByFhYmr9Eg2ikiX2hGHvGk/+uptYxh1RD
        n9eNxvHWWqJBmnbGdcwARpEVREwM+VI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-zfnYUARkOFmKjypykUW79w-1; Mon, 16 Aug 2021 11:56:38 -0400
X-MC-Unique: zfnYUARkOFmKjypykUW79w-1
Received: by mail-ed1-f69.google.com with SMTP id e3-20020a50ec830000b02903be5be2fc73so9015283edr.16
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PZpQLZMB7RJdGulqivRZelq1MarObE9Ch/tXNewyPHo=;
        b=PFN/fkWtrJF4Vx5utg8k0wlCiDFOWmcxav5vz1h2598vE0RxDR8lUlx+Q7+kMfLfCU
         k7bDZQ3Kxzztu39p0GIdKHRdVxPrFDFMcH7X3VwEs/ZVZbrU2eGu0qGH+HS7Bow7QT3/
         RL02VuZ5NI+RqorWcJ3ONqa2L9DkIle+H6my7Koay6dtUOFxO7LxEhLZ4ltnIcIonICX
         JBj+OLaGfKNUKsptMxNWh9oDoBXZ+Vy1DYgGd4gzXah5Etqgx6CUZfCHGu7iLJ1Z5vSW
         3ckSBGGI0BKF6SJ/SRgBKGo+ZvThfnCq8zZt1C+xy/t6v0I/FRK4kN9PIVm/9vVO+wGE
         NKjQ==
X-Gm-Message-State: AOAM532t/a/VNbcCTk6pNqsAk/mEeX+UAJKfl/P5v6D+CR9SUE/1CkqF
        57zy85F5gWnH/0R/WU6cQZec1IeItWQd8VOI/orslckN/uxrtSMTsMUyauSdwqJ0OOhKXJITsW8
        rSZbX+c5+ta9JS86xkK+SSNLc
X-Received: by 2002:aa7:c894:: with SMTP id p20mr21016339eds.42.1629129397235;
        Mon, 16 Aug 2021 08:56:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0zVXLSgao02pT8Fnch/EOLmPpvxZgNu0lTTzYEYe6LDXa/xwx5yX+prRxBm3ZPVFWwFWf4g==
X-Received: by 2002:aa7:c894:: with SMTP id p20mr21016321eds.42.1629129397047;
        Mon, 16 Aug 2021 08:56:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id i11sm5047064edu.97.2021.08.16.08.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 08:56:36 -0700 (PDT)
Subject: Re: [PATCH 5.12.y] KVM: nSVM: avoid picking up unsupported bits from
 L2 in int_ctl (CVE-2021-3653)
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
References: <20210816140240.11399-6-pbonzini@redhat.com>
 <YRp1bUv85GWsFsuO@kroah.com>
 <97448bb5-1f58-07f9-1110-96c7ffefd4b2@redhat.com>
 <YRqAM3gTAscfmr60@kroah.com>
 <74cf96a9030dc0e996b1814bbf907299e377053e.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad855723-fe97-6916-8d96-013021e19fc7@redhat.com>
Date:   Mon, 16 Aug 2021 17:56:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <74cf96a9030dc0e996b1814bbf907299e377053e.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/21 17:37, Maxim Levitsky wrote:
> 5.13 will more likely to work with the upstream version.
> I'll check it soon.

There are a couple context differences so I've already tested it and 
sent it out.

Paolo

