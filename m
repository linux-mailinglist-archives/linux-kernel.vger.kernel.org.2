Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7D36A108
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbhDXL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhDXL6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 07:58:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ADDC061574;
        Sat, 24 Apr 2021 04:57:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id g16so9649864plq.3;
        Sat, 24 Apr 2021 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1obLN2ZKP0a6DWoAypmeePpnDE55lbsbkQk2JOkaCSk=;
        b=HRurumi9Ig08GEqMevUwh9x1pdZ+Tc5efvmB7V5OVryoc2S942DNxWaqwG+zRO3wK1
         3NiewSlC31NchUoDxyenWjclG2fAZIYQMkq1p34frHEoiaP3XZsZOWceBWr1VeQtdqFF
         yMvDqTZUlN3Ei6nHxWB6uko4dPWcnR+jB+gyhsa7qs3GMHiwez8CavN8xvN/ifNsRfzA
         L7Ad6j1Q3EULz2CF47mPMe8hyx5GX3cfeFnzLIYZdCjqoFL25Ta6PNXSoGAFEzLEb8lt
         Wqsv/wi1s0gYkhF2IOEfjCgYWDcO5LcNNjzjXSKt9yM69xqq3q0/WG2XfjdVcpXC5pDD
         ZD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1obLN2ZKP0a6DWoAypmeePpnDE55lbsbkQk2JOkaCSk=;
        b=ia3eZWTL1C3bHPva3VzHdtHrG0U4hfHgMP6QSlZ41lWQmT38ItbXhvfZDM+VyU7rXs
         iOQvMzbQRiXHPKen8up30niP/9za1Zzgy0XGhMu5xTBNFPK58N5fbdLbMdxgKhjfp9VI
         rxWb6J3BJdnI3W7guV+2mxbR7S9xzq+Z8QlOpUSy+zSTwwARpxuShISWgBvjUzT094rs
         P96gmYX+VNopv/QXMldL6XqWPgXyRuJ5hpnrVxLGpU9mHRBj5rjSDLIRm3PxdLXd/R5A
         5kmFNSiczhg187vXt9V8wY6ep83k6FNt8qPzgIoibcUZzHr879g+YdxJUTV6rz7WjWd3
         0wmQ==
X-Gm-Message-State: AOAM532ZO+AbwrK4dlB+Ab/xUkW1vyIP7DLvyWFys2ovipw253ydbSTz
        htPdYEsaaKQTIEihl0FzqT0oL/8epqdn3Q==
X-Google-Smtp-Source: ABdhPJzOc524x4lR1bVjUOUQNmGWBNhq285gGf0/lJhTrxE8haEuCHcaBPoDETYQXzwxMRjXC70a+w==
X-Received: by 2002:a17:90b:e8b:: with SMTP id fv11mr9674312pjb.66.1619265460165;
        Sat, 24 Apr 2021 04:57:40 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a089:2cc5:55e8:20f9:7536? ([2405:201:600d:a089:2cc5:55e8:20f9:7536])
        by smtp.gmail.com with ESMTPSA id 14sm6770579pfl.1.2021.04.24.04.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 04:57:39 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: reduce repeated regex expressions into
 variables
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210422191839.6119-1-yashsri421@gmail.com>
 <20210423132117.GB235567@casper.infradead.org>
Message-ID: <6f76ddcb-7076-4c91-9c4c-995002c4cb91@gmail.com>
Date:   Sat, 24 Apr 2021 17:27:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210423132117.GB235567@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/4/21 6:51 pm, Matthew Wilcox wrote:
> On Fri, Apr 23, 2021 at 12:48:39AM +0530, Aditya Srivastava wrote:
>> +my $pointer_function = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
> 
> Is that a pointer-to-function?  Or as people who write C usually call it,
> a function pointer?  Wouldn't it be better to call it $function_pointer?
> 
Will do it.

>> @@ -1210,8 +1211,14 @@ sub dump_struct($$) {
>>      my $decl_type;
>>      my $members;
>>      my $type = qr{struct|union};
>> +    my $packed = qr{__packed};
>> +    my $aligned = qr{__aligned};
>> +    my $cacheline_aligned_in_smp = qr{____cacheline_aligned_in_smp};
>> +    my $cacheline_aligned = qr{____cacheline_aligned};
> 
> I don't think those four definitions actually simplify anything.
> 
>> +    my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
> 
> ... whereas this one definitely does.
> 
>> -	$members =~ s/\s*__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)/ /gi;
>> -	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
>> -	$members =~ s/\s*__packed\s*/ /gos;
>> +	$members =~ s/\s*$attribute/ /gi;
>> +	$members =~ s/\s*$aligned\s*\([^;]*\)/ /gos;
> 
> Maybe put the \s*\([^;]*\) into $aligned?  Then it becomes a useful
> abstraction.

Actually, I had made these variables as they were repeated here and at
-    my $definition_body =
qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
+    my $definition_body =
qr{\{(.*)\}(?:\s*(?:$packed|$aligned|$cacheline_aligned_in_smp|$cacheline_aligned|$attribute))*};

So, defining them at a place might help.

What do you think?

> 
>> -    } elsif ($prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>> -	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>> -	$prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
>> -	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+\s*\*+\s*\w+\s*\*+\s*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/)  {
>> +    } elsif ($prototype =~ m/^()($name)\s*$prototype_end1/ ||
>> +	$prototype =~ m/^(\w+)\s+($name)\s*$prototype_end1/ ||
>> +	$prototype =~ m/^(\w+\s*\*+)\s*($name)\s*$prototype_end1/ ||
>> +	$prototype =~ m/^(\w+\s+\w+)\s+($name)\s*$prototype_end1/ ||
>> +	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*($name)\s*$prototype_end1/ ||
>> +	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+($name)\s*$prototype_end1/ ||
>> +	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*($name)\s*$prototype_end1/ ||
>> +	$prototype =~ m/^()($name)\s*$prototype_end2/ ||
>> +	$prototype =~ m/^(\w+)\s+($name)\s*$prototype_end2/ ||
>> +	$prototype =~ m/^(\w+\s*\*+)\s*($name)\s*$prototype_end2/ ||
>> +	$prototype =~ m/^(\w+\s+\w+)\s+($name)\s*$prototype_end2/ ||
>> +	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*($name)\s*$prototype_end2/ ||
>> +	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+($name)\s*$prototype_end2/ ||
>> +	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*($name)\s*$prototype_end2/ ||
>> +	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+)\s+($name)\s*$prototype_end2/ ||
>> +	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+\s*\*+)\s*($name)\s*$prototype_end2/ ||
>> +	$prototype =~ m/^(\w+\s+\w+\s*\*+\s*\w+\s*\*+\s*)\s*($name)\s*$prototype_end2/)  {
> 
> This is probably the best patch I've seen so far this year.
> 
> Now, can we go further?  For example:
> 	$prototype_end = $prototype_end1|$prototype_end2
> That would let us cut the number of lines here in half.
> > Can we create a definition for a variable number of \w and \s and '*'
> in the return type?  In fact, can we define a regex that matches a type?
> So this would become:
> 
>> +    } elsif ($prototype =~ m/^($type)\s*($name)\s*$prototype_end/) {
> 

I have been able to reduce these expressions furthermore. Will send a
v2 in few..

Thanks
Aditya
