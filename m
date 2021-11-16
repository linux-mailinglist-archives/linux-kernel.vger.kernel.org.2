Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1EF453796
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhKPQgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbhKPQgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:36:52 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BFDC061746;
        Tue, 16 Nov 2021 08:33:55 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t23so12342425oiw.3;
        Tue, 16 Nov 2021 08:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LlxygBrGDQWQgkQKbo6h1xP90fhPlZPtnoixKFIvswQ=;
        b=U8ynJPhYmZw4y3AgDjF9X0Ro+obiOWxglyAJvQg7el3E0ruoO48xC/osRtFqclOzUB
         MqZ5kQD65fNb7DnxE8JggTGx2VbBdktyKmjpK3sFYNnMQh/v3h29IBdO97fadhIgtUrq
         m/q+M2JvTyMjU5/5b/O5lzGj7dS28mDV7I1AELbgsvepIsD7NPkUk8Oh3q57jA3KvoOQ
         B6flAySP81AWiXv8J6tlAEB5B3TyQiatTPGKiiQSDk4a3ame7lUMU9t5UiUm5XucB0kH
         oYkS+GKoffdvD/dN2NaNsQCJFo99WdldgMKFZ9N6IwgxExKzmRFmuhXcw4tz0oqXgMQe
         yBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LlxygBrGDQWQgkQKbo6h1xP90fhPlZPtnoixKFIvswQ=;
        b=PSmhtVow04/ZUS8saFAXmvatfUoEizzHEOs3/mVffOsHQRNdZCpR3CQ7CMdsnUkLdN
         RjW2SZ22fyiyFcPXp+wcy+s/UdjexjDFhWk3MrH+Zy7saDtQxRci5Ts3P2Y8ISliqroI
         T1Z1QcABef9CVL2D6gIwhQvl29aPihkPw2Ak6+MfnUa8hsBgR7lIJ3iqbQHuBLpQRgBr
         oRc0bD1I6qe0pjTcEiyKcYsd5687B+JpP2efOttH07kvcezC978wQPd9vCo9bZyNXd3N
         FXf2JqdvxW8LUHgAw9TH+Jd0+sa35mRqsfo0yEmNztxpAdFPh0jwKS4oYYnNrv6uv/SP
         a4Vw==
X-Gm-Message-State: AOAM531SmnLNm7U9Ovq2reYCkNE60ZuOFBNMgTjpvUS/j6epDODLDirV
        sWNhkfpOdARVWXO1JIa05o0=
X-Google-Smtp-Source: ABdhPJyeXYp7WX+skGLcooZeHeigxd0zf6FS/5WhEKsAlyLurKL+PWXivzNtvn3iVP6E9K/1bCMLUQ==
X-Received: by 2002:aca:1204:: with SMTP id 4mr50102134ois.136.1637080434814;
        Tue, 16 Nov 2021 08:33:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q9sm3603638oti.32.2021.11.16.08.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 08:33:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (tmp401) Fix clang -Wimplicit-fallthrough in
 tmp401_is_visible()
To:     Nathan Chancellor <nathan@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20211116154438.1383290-1-nathan@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <34038273-3d00-a8e0-d6dc-4317fe56c0d1@roeck-us.net>
Date:   Tue, 16 Nov 2021 08:33:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116154438.1383290-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 7:44 AM, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/hwmon/tmp401.c:526:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>          default:
>          ^
> drivers/hwmon/tmp401.c:526:2: note: insert 'break;' to avoid fall-through
>          default:
>          ^
>          break;
> 1 error generated.
> 
> Clang is a little more pedantic than GCC, which does not warn when
> falling through to a case that is just break or return. Clang's version
> is more in line with the kernel's own stance in deprecated.rst, which
> states that all switch/case blocks must end in either break,
> fallthrough, continue, goto, or return. Add the missing break to silence
> the warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1505
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> Feel free to squash this into the offending commit.

Done, thanks a lot for the feedback.

Guenter

> 
>   drivers/hwmon/tmp401.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index f7b6a2c4fbcf..b86d9df7105d 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -523,6 +523,7 @@ static umode_t tmp401_is_visible(const void *data, enum hwmon_sensor_types type,
>   		default:
>   			break;
>   		}
> +		break;
>   	default:
>   		break;
>   	}
> 
> base-commit: 82b520da9134a594eb9816759ed66ba6ef44888e
> 

