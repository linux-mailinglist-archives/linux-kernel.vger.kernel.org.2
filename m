Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6267F3240A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbhBXPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:19:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237767AbhBXOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614177519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cClZ4arkqcsGEilDhwa9v6Cj8IXTZ3mm/jsLqqThEsQ=;
        b=LV/clOdrvJkevlIjFeyD56sH3i5eMozSBILkIfhC3/yUPuXVmX/JMLqRpqBMd3AuvJcd+T
        yI3qtHQgxDcPYHCzxvfLB6ym2ALviEj59g8wrq43D/jKllfpm2lgcrDL09VCasXx1XhhxN
        kYSt2IBNcIcK3pPFC8I6MtXrQ+7iG3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-5df787PPMneRfs8pTt_H6A-1; Wed, 24 Feb 2021 09:37:00 -0500
X-MC-Unique: 5df787PPMneRfs8pTt_H6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 604898C249F;
        Wed, 24 Feb 2021 13:43:48 +0000 (UTC)
Received: from krava (unknown [10.40.193.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id B059C19C46;
        Wed, 24 Feb 2021 13:43:45 +0000 (UTC)
Date:   Wed, 24 Feb 2021 14:43:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH 2/2] perf buildid-cache: Add test for PE executable
Message-ID: <YDZYEKJ7w+XgqA7S@krava>
References: <295f5380-93a1-78fa-884b-afd4319b96d7@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295f5380-93a1-78fa-884b-afd4319b96d7@codeweavers.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:10:34AM -0500, Nicholas Fraser wrote:

SNIP

> +if ! which wine > /dev/null; then
> +    echo "WARNING: wine not found. PE binaries will not be run."
> +    run_pe=0
> +fi
> +
>  ex_md5=$(mktemp /tmp/perf.ex.MD5.XXX)
>  ex_sha1=$(mktemp /tmp/perf.ex.SHA1.XXX)
> +ex_pe=$(dirname $0)/../pe-file.exe
>  
>  echo 'int main(void) { return 0; }' | cc -Wl,--build-id=sha1 -o ${ex_sha1} -x c -
>  echo 'int main(void) { return 0; }' | cc -Wl,--build-id=md5 -o ${ex_md5} -x c -
>  
> -echo "test binaries: ${ex_sha1} ${ex_md5}"
> +echo "test binaries: ${ex_sha1} ${ex_md5} ${ex_pe}"
>  
>  check()
>  {
> -	id=`readelf -n ${1} 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
> -
> +	case $1 in
> +	*.exe)
> +		# the build id must be rearranged into a GUID
> +		id=`objcopy -O binary --only-section=.buildid $1 /dev/stdout | \
> +			cut -c 33-48 | hexdump -ve '/1 "%02x"' | \
> +			sed 's@^\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(.*\)0a$@\4\3\2\1\6\5\8\7\9@'`
> +		;;

wow ;-) could this have some more info on what's going on in here?
what's the .buildid PE section format?

> +	*)
> +		id=`readelf -n ${1} 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
> +		;;
> +	esac
>  	echo "build id: ${id}"
>  
>  	link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
> @@ -50,7 +73,7 @@ check()
>  		exit 1
>  	fi
>  
> -	${perf} buildid-cache -l | grep $id
> +	${perf} buildid-cache -l | grep ${id}
>  	if [ $? -ne 0 ]; then
>  		echo "failed: ${id} is not reported by \"perf buildid-cache -l\""
>  		exit 1
> @@ -81,7 +104,7 @@ test_record()
>  	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
>  	perf="perf --buildid-dir ${build_id_dir}"
>  
> -	${perf} record --buildid-all -o ${data} ${1}
> +	${perf} record --buildid-all -o ${data} ${2} ${1}

it could be better just pass $@ and make sure test_record
args are passed in a way that record would accept them

  test_record wine ${ex_pe}


>  	if [ $? -ne 0 ]; then
>  		echo "failed: record ${1}"
>  		exit 1
> @@ -96,12 +119,22 @@ test_record()
>  # add binaries manual via perf buildid-cache -a
>  test_add ${ex_sha1}
>  test_add ${ex_md5}
> +if [ $add_pe -eq 1 ]; then

${add_pe}

> +    test_add ${ex_pe}
> +fi
>  
>  # add binaries via perf record post processing
>  test_record ${ex_sha1}
>  test_record ${ex_md5}
> +if [ $run_pe -eq 1 ]; then

${run_pe}

> +    test_record ${ex_pe} wine

I'm getting lot of wine's output, we should redirect that

every other run I'm getting some small window popup saying it's
updating wine and stuck forever.. could this be prevented?

> +fi
>  
>  # cleanup
>  rm ${ex_sha1} ${ex_md5}
>  
> +if [ $add_pe -eq 0 ] || [ $run_pe -eq 0 ]; then
> +    echo "WARNING: some PE tests were skipped. See previous warnings."
> +fi

there's already a warning for this at the beginning,
I dont think we need another one

thanks,
jirka

> +
>  exit ${err}
> -- 
> 2.30.1
> 

