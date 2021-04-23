Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1943691EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242478AbhDWMVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhDWMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:21:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE598C061574;
        Fri, 23 Apr 2021 05:20:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w6so19427783pfc.8;
        Fri, 23 Apr 2021 05:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=puoDTfvhjQbGo57jYiB9OwNTmwysMKQM/yfSRh13jiY=;
        b=K4o+6klSACs+EiTu/tfdFgOes+iAVN+A87ScCR6rXxHTlTAay8pYH15MymOhuiVnyx
         NrqsE6WZ8tSjDlvFalUGG3xzNov2d4qak1qoI8oVzE2bq1fSyzKFnSYYAsS3BDQf7SJm
         cL1u+ORmm48UwmDkOqPChLF5R9fTGUFPwnXWlzGVbi0w3qdFFeppKCiN7DbJL0iH5G6D
         mtQ30t/Gj8jn4kSR6ZP/tsnciWgeHoUgvc+LGi8Q4pic1lRcnj1STgsJrBo+h2t4smUX
         VGj0dAQbKMJNfDWlhFqUF7Mr0cDfWxULjL4qHTKIqE7uMVhADXtzSj6fMwkJSmaND04M
         hgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=puoDTfvhjQbGo57jYiB9OwNTmwysMKQM/yfSRh13jiY=;
        b=pwZON6nda6D7w6cW77V1AKV2YSaSjQVVHNT9mujIPBcnhpCX/EWtdJAHpr2SHHPY6Z
         8g39joeM637BKaF1fqWLT2kofj4vGsf1nfvd404+TVTOTblDPCc7PehmIPA0AaY7ua84
         V4Vi9kZpkg/tnei7dPlZUC0tBDB3/FNxdTDzsEeT+xp7t3zYgJ83SLCZ12yMEqzEiz3a
         v3uCNE871lLXzq8qv3alytEHZun4RECCAKehnh+NnGeJyBMzg0l/YNP0WCpWhmjWZpsS
         ve3gPw7Im9Qe8su7Sd5AtzehGF7Am2CMPMpZOuYAlnF3BrO398AwY/SXP/RrY64O8wP3
         BR2w==
X-Gm-Message-State: AOAM532UiGhKVeB6RAWHywN/cI21ZyfYegw4CYcZX+btA1hUuwYRsG1e
        65UVsrBU/UClA0jjlEtTykJFYirMK2rRFQ==
X-Google-Smtp-Source: ABdhPJx0qTp2K7ITbWxQKB536T+HSeYJvu1E9vWhXtepDdq0Qa2thhMZc6Zmxd6wd0icTFHdZxTUYg==
X-Received: by 2002:a63:231c:: with SMTP id j28mr3456276pgj.165.1619180438011;
        Fri, 23 Apr 2021 05:20:38 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a089:d9c1:8320:7f58:f75a? ([2405:201:600d:a089:d9c1:8320:7f58:f75a])
        by smtp.gmail.com with ESMTPSA id gw19sm4966851pjb.4.2021.04.23.05.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 05:20:37 -0700 (PDT)
Subject: Re: [RFC] scripts: kernel-doc: reduce repeated regex expressions into
 variables
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210422191839.6119-1-yashsri421@gmail.com>
 <CAKXUXMx9q57cWXkcezKKo-uuh21Sd-Si9M9KydzFEMQ0ELYEng@mail.gmail.com>
From:   Aditya Srivastava <yashsri421@gmail.com>
Message-ID: <1101eeb0-306f-dbea-8819-8bddd80d361c@gmail.com>
Date:   Fri, 23 Apr 2021 17:50:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMx9q57cWXkcezKKo-uuh21Sd-Si9M9KydzFEMQ0ELYEng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/4/21 1:03 am, Lukas Bulwahn wrote:
> Aditya Srivastava <yashsri421@gmail.com> schrieb am Do., 22. Apr. 2021,
> 21:18:
> 
>> There are some regex expressions in the kernel-doc script, which are used
>> repeatedly in the script.
>>
>> Reduce such expressions into variables, which can be used everywhere.
>>
>> A quick manual check found that no errors and warnings were added/removed
>> in this process.
>>
>> Suggested-by: Jonathan Corbet <corbet@lwn.net>
>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>> ---
>>  scripts/kernel-doc | 89 ++++++++++++++++++++++++++--------------------
>>  1 file changed, 50 insertions(+), 39 deletions(-)
>>
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index 2a85d34fdcd0..579c9fdd275f 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -406,6 +406,7 @@ my $doc_inline_sect =
>> '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
>>  my $doc_inline_end = '^\s*\*/\s*$';
>>  my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
>>  my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
>> +my $pointer_function = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
>>
>>  my %parameterdescs;
>>  my %parameterdesc_start_lines;
>> @@ -694,7 +695,7 @@ sub output_function_man(%) {
>>             $post = ");";
>>         }
>>         $type = $args{'parametertypes'}{$parameter};
>> -       if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
>> +       if ($type =~ m/$pointer_function/) {
>>             # pointer-to-function
>>             print ".BI \"" . $parenth . $1 . "\" " . " \") (" . $2 . ")" .
>> $post . "\"\n";
>>         } else {
>> @@ -974,7 +975,7 @@ sub output_function_rst(%) {
>>         $count++;
>>         $type = $args{'parametertypes'}{$parameter};
>>
>> -       if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
>> +       if ($type =~ m/$pointer_function/) {
>>             # pointer-to-function
>>             print $1 . $parameter . ") (" . $2 . ")";
>>         } else {
>> @@ -1210,8 +1211,14 @@ sub dump_struct($$) {
>>      my $decl_type;
>>      my $members;
>>      my $type = qr{struct|union};
>> +    my $packed = qr{__packed};
>> +    my $aligned = qr{__aligned};
>> +    my $cacheline_aligned_in_smp = qr{____cacheline_aligned_in_smp};
>> +    my $cacheline_aligned = qr{____cacheline_aligned};
>> +    my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
>>      # For capturing struct/union definition body, i.e.
>> "{members*}qualifiers*"
>> -    my $definition_body =
>> qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
>> +    my $definition_body =
>> qr{\{(.*)\}(?:\s*(?:$packed|$aligned|$cacheline_aligned_in_smp|$cacheline_aligned|$attribute))*};
>> +    my $struct_members =
>> qr{($type)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;};
>>
>>      if ($x =~ /($type)\s+(\w+)\s*$definition_body/) {
>>         $decl_type = $1;
>> @@ -1235,27 +1242,27 @@ sub dump_struct($$) {
>>         # strip comments:
>>         $members =~ s/\/\*.*?\*\///gos;
>>         # strip attributes
>> -       $members =~ s/\s*__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)/ /gi;
>> -       $members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
>> -       $members =~ s/\s*__packed\s*/ /gos;
>> +       $members =~ s/\s*$attribute/ /gi;
>> +       $members =~ s/\s*$aligned\s*\([^;]*\)/ /gos;
>> +       $members =~ s/\s*$packed\s*/ /gos;
>>         $members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
>> -       $members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
>> -       $members =~ s/\s*____cacheline_aligned/ /gos;
>> +       $members =~ s/\s*$cacheline_aligned_in_smp/ /gos;
>> +       $members =~ s/\s*$cacheline_aligned/ /gos;
>>
>> +       my $args = qr{([^,)]+)};
>>         # replace DECLARE_BITMAP
>>         $members =~
>> s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1,
>> __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
>> -       $members =~ s/DECLARE_BITMAP\s*\(([^,)]+),\s*([^,)]+)\)/unsigned
>> long $1\[BITS_TO_LONGS($2)\]/gos;
>> +       $members =~ s/DECLARE_BITMAP\s*\($args,\s*$args\)/unsigned long
>> $1\[BITS_TO_LONGS($2)\]/gos;
>>         # replace DECLARE_HASHTABLE
>> -       $members =~
>> s/DECLARE_HASHTABLE\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[1 << (($2)
>> - 1)\]/gos;
>> +       $members =~ s/DECLARE_HASHTABLE\s*\($args,\s*$args\)/unsigned long
>> $1\[1 << (($2) - 1)\]/gos;
>>         # replace DECLARE_KFIFO
>> -       $members =~
>> s/DECLARE_KFIFO\s*\(([^,)]+),\s*([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
>> +       $members =~ s/DECLARE_KFIFO\s*\($args,\s*$args,\s*$args\)/$2
>> \*$1/gos;
>>         # replace DECLARE_KFIFO_PTR
>> -       $members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2
>> \*$1/gos;
>> -
>> +       $members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
>>         my $declaration = $members;
>>
>>         # Split nested struct/union elements as newer ones
>> -       while ($members =~
>> m/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/) {
>> +       while ($members =~ m/$struct_members/) {
>>                 my $newmember;
>>                 my $maintype = $1;
>>                 my $ids = $4;
>> @@ -1315,7 +1322,7 @@ sub dump_struct($$) {
>>                                 }
>>                         }
>>                 }
>> -               $members =~
>> s/(struct|union)([^\{\};]+)\{([^\{\}]*)\}([^\{\}\;]*)\;/$newmember/;
>> +               $members =~ s/$struct_members/$newmember/;
>>         }
>>
>>         # Ignore other nested elements, like enums
>> @@ -1555,8 +1562,9 @@ sub create_parameterlist($$$$) {
>>      my $param;
>>
>>      # temporarily replace commas inside function pointer definition
>> -    while ($args =~ /(\([^\),]+),/) {
>> -       $args =~ s/(\([^\),]+),/$1#/g;
>> +    my $arg_expr = qr{\([^\),]+};
>> +    while ($args =~ /$arg_expr,/) {
>> +       $args =~ s/($arg_expr),/$1#/g;
>>      }
>>
>>      foreach my $arg (split($splitter, $args)) {
>> @@ -1808,8 +1816,11 @@ sub dump_function($$) {
>>      # - parport_register_device (function pointer parameters)
>>      # - atomic_set (macro)
>>      # - pci_match_device, __copy_to_user (long return type)
>> +    my $name = qr{[a-zA-Z0-9_~:]+};
>> +    my $prototype_end1 = qr{\(([^\(]*)\)};
>> +    my $prototype_end2 = qr{\(([^\{]*)\)};
>>
> 
> Why do you need end1 and end2 here?
> 

Thanks for pointing out, Lukas. I am looking into the possibility of
combining these expressions, and testing against the files.
Please let me know if there are any more improvements possible :)

Thanks
Aditya
