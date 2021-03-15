Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9933C860
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 22:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhCOVS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 17:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhCOVSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:18:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C31C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:18:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a188so7406581pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=nf5/IBHtOqEnzpwQ2hzohU0Ag5wcCxnUnDujkdVZjqQ=;
        b=VLzzb7jZxH7108mAHzIH5LTOIZ9NzNG+OWOXXmQrEllcLHxWNeOMtt5jyIRFn8Jf8K
         s/zj9RCtrDB+SW7LkiusH9bsXRuDcTZ4ciCyddeY92SQnNnJBpe1Rm5cwKYREB8pi50J
         fAXsiJFvRdgWNbnVwdRa7HRAR+VD6iea/WACJpkvInH4+AjS7iInqznrPLTTmVtXhlez
         E9oaRpXiwfbZ+emBZqfQ20sz1IOguL3ojOJFn2PahIZZ0ZQP3K8TvSD3+fB5z1mVjf/1
         NHAk1LnyMLR9MUJbr5xKysl/o6YZzKXkXsk6B5CK2hfNlz46CA1/bfBixZTKLOvJwFRq
         bCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nf5/IBHtOqEnzpwQ2hzohU0Ag5wcCxnUnDujkdVZjqQ=;
        b=SszRVatuWjpjFnmN6MSIGq4RoxONcZqQuUEXAxu+RoBKCaN2YxXg45ElDfTe8pq8HC
         jzN9eMV6wCis+DwHEpJZ7iHUOGSufbQpXBRrUZeEzJawz05HKjB+8HLkmM1dQS4GiexB
         bVwblRcCHumPPHIolmH1/zoY6h21xfgUA43OcRyKPM+ESGd/9xE1HblJB4Kh7x7w7p7Z
         EUtxUKU0/VGpOumuB+3Q7SxEauLIVQrnLTlHQYYxuJYndA0T/eyDcLcPwFR62+yvbY8T
         jQG87P0oZ2DUMbPAVhuIcc7ouTGFc3058IM7fAIqhg6aD6iWE7ULori13H89PFBfPEjo
         UcEA==
X-Gm-Message-State: AOAM532x6uhww+UlFBLURySQs3aCk3KpEzTqwsT0Ql48jmzEWcbJ2v1v
        IvifT8mkZDp6CXAj+7kXLMc=
X-Google-Smtp-Source: ABdhPJxacFzVAqwja69LltuJ6/x8cQ/yZazGQluZOnzzkLcTqpRIRrCMWyD//0yXbK03bZZLnDHpTw==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr880149pgl.29.1615843095239;
        Mon, 15 Mar 2021 14:18:15 -0700 (PDT)
Received: from [192.168.0.2] (c-73-202-109-61.hsd1.ca.comcast.net. [73.202.109.61])
        by smtp.googlemail.com with ESMTPSA id i25sm2924993pfa.162.2021.03.15.14.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 14:18:14 -0700 (PDT)
Subject: Re: 5.12-rc1 and -rc2 - BUG/crash after KVM/USB connect/disconnect.
From:   Robert Gadsdon <rhgadsdon@gmail.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <43c65825-a272-9e4f-7b63-5693f44c5db3@gmail.com>
Message-ID: <05519e37-791f-f148-770f-7f6eec19045f@gmail.com>
Date:   Mon, 15 Mar 2021 14:18:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <43c65825-a272-9e4f-7b63-5693f44c5db3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed in 5.12-rc3.   Thanks.

RG.

